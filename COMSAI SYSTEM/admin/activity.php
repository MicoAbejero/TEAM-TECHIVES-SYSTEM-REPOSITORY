<?php

declare(strict_types=1);

require_once __DIR__ . '/_layout.php';
app_security_headers();
$admin = require_admin();
if ($admin['role'] !== 'admin') {
    http_response_code(403);
    admin_layout_start('Chatbot activity', 'activity.php');
    echo '<div class="alert">Administrator access required.</div>';
    admin_layout_end();
    exit;
}

$pdo = db();
$daily = $pdo->query("SELECT DATE(created_at) AS day,COUNT(*) AS question_count FROM chat_messages WHERE sender='student' AND created_at>=DATE_SUB(CURDATE(),INTERVAL 13 DAY) GROUP BY DATE(created_at) ORDER BY day DESC")->fetchAll();
$q = trim((string) ($_GET['q'] ?? ''));
$sort = in_array($_GET['sort'] ?? '', ['latest', 'oldest', 'title'], true) ? (string) $_GET['sort'] : 'latest';
$orderBy = match ($sort) {
    'oldest' => 'created_at ASC, id ASC',
    'title' => 'message ASC, id ASC',
    default => 'created_at DESC, id DESC',
};
$recent = $pdo->query("SELECT id,message,created_at FROM (SELECT id,message,created_at FROM chat_messages WHERE sender='student' ORDER BY id DESC LIMIT 30) AS recent_questions ORDER BY {$orderBy}")->fetchAll();
$latestChatMessageId = (int) ($pdo->query("SELECT COALESCE(MAX(id), 0) FROM chat_messages WHERE sender='student'")->fetchColumn() ?: 0);
$previousSeen = $pdo->prepare('SELECT last_seen_chat_message_id FROM admin_activity_state WHERE admin_id=:admin');
$previousSeen->execute(['admin' => $admin['id']]);
$previousSeenId = (int) ($previousSeen->fetchColumn() ?: 0);
$markSeen = $pdo->prepare('INSERT INTO admin_activity_state (admin_id,last_seen_chat_message_id) VALUES (:admin,:latest) ON DUPLICATE KEY UPDATE last_seen_chat_message_id=GREATEST(last_seen_chat_message_id,VALUES(last_seen_chat_message_id))');
$markSeen->execute(['admin' => $admin['id'], 'latest' => $latestChatMessageId]);

$error = '';
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!verify_csrf()) {
        $error = 'Form expired. Refresh and try again.';
    } else {
        try {
            if (($_POST['action'] ?? '') !== 'bulk_delete') throw new RuntimeException('Choose the delete action.');
            $submittedIds = $_POST['ids'] ?? [];
            if (!is_array($submittedIds) || $submittedIds === []) throw new RuntimeException('Select at least one student question.');
            $ids = array_values(array_unique(array_filter(
                array_map(static fn ($value) => filter_var($value, FILTER_VALIDATE_INT), $submittedIds),
                static fn ($id) => $id !== false && $id > 0
            )));
            if ($ids === []) throw new RuntimeException('Select at least one valid student question.');
            if (count($ids) > 30) throw new RuntimeException('Select no more than 30 student questions.');

            $pdo->beginTransaction();
            try {
                $placeholders = implode(',', array_fill(0, count($ids), '?'));
                $existing = $pdo->prepare("SELECT id FROM chat_messages WHERE sender='student' AND id IN ($placeholders)");
                $existing->execute($ids);
                foreach ($existing->fetchAll(PDO::FETCH_COLUMN) as $id) {
                    admin_log($pdo, $admin['id'], 'delete', 'chat_message', (int) $id);
                }
                $delete = $pdo->prepare("DELETE FROM chat_messages WHERE sender='student' AND id IN ($placeholders)");
                $delete->execute($ids);
                $pdo->commit();
            } catch (Throwable $exception) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                throw $exception;
            }

            $returnQuery = trim((string) ($_POST['return_q'] ?? ''));
            $returnSort = in_array($_POST['return_sort'] ?? '', ['latest', 'oldest', 'title'], true) ? (string) $_POST['return_sort'] : 'latest';
            $state = array_filter(['q' => $returnQuery, 'sort' => $returnSort === 'latest' ? '' : $returnSort], static fn ($value): bool => $value !== '');
            $state['saved'] = '1';
            header('Location: activity.php?' . http_build_query($state));
            exit;
        } catch (Throwable $exception) {
            error_log('NEW COMSAI activity delete failed: ' . $exception->getMessage());
            $error = $exception instanceof RuntimeException ? $exception->getMessage() : 'Could not delete the selected student questions.';
        }
    }
}

admin_layout_start('Chatbot activity', 'activity.php');
?>
<?php if ($error): ?><div class="alert" role="alert"><?= h($error) ?></div><?php elseif (isset($_GET['saved'])): ?><div class="success" role="status">Selected student questions deleted.</div><?php endif; ?>
<section class="stats-grid"><article class="stat-card"><span>All recorded questions</span><strong><?=(int)$pdo->query("SELECT COUNT(*) FROM chat_messages WHERE sender='student'")->fetchColumn()?></strong><small>Anonymous session records</small></article><article class="stat-card"><span>Active conversations</span><strong><?=(int)$pdo->query('SELECT COUNT(*) FROM chat_sessions')->fetchColumn()?></strong><small>Session-scoped, no student accounts</small></article><article class="stat-card"><span>Questions in last 14 days</span><strong><?=(int)$pdo->query("SELECT COUNT(*) FROM chat_messages WHERE sender='student' AND created_at>=DATE_SUB(NOW(),INTERVAL 14 DAY)")->fetchColumn()?></strong><small>Usage only, not student identity</small></article></section>
<section class="admin-section activity-section">
  <div class="section-title"><div><h2>Recent student questions</h2><p>Questions are retained for up to 30 days; avoid collecting personal details.</p></div></div>
  <form method="get" class="filter-bar" data-activity-search>
    <div class="field"><label for="activity-q">Search questions</label><div class="admin-search-input"><input id="activity-q" name="q" value="<?= h($q) ?>" autocomplete="off" placeholder="Search student questions"><span aria-hidden="true"><svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"></circle><path d="m16 16 4 4"></path></svg></span><button class="admin-search-clear" type="button" data-search-clear aria-label="Clear search" hidden><svg viewBox="0 0 24 24" aria-hidden="true"><path d="m6 6 12 12M18 6 6 18"></path></svg></button></div></div>
    <div class="field"><label for="activity-sort">Sort by</label><select id="activity-sort" name="sort"><option value="latest" <?= $sort === 'latest' ? 'selected' : '' ?>>Latest</option><option value="oldest" <?= $sort === 'oldest' ? 'selected' : '' ?>>Oldest</option><option value="title" <?= $sort === 'title' ? 'selected' : '' ?>>Alphabetical</option></select></div>
  </form>
  <form id="activity-bulk-form" method="post" class="knowledge-bulk-toolbar activity-bulk-toolbar">
    <input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><input type="hidden" name="return_q" value="<?= h($q) ?>"><input type="hidden" name="return_sort" value="<?= h($sort) ?>"><input type="hidden" name="action" value="bulk_delete">
    <span id="activity-selection-count" aria-live="polite">0 selected</span><button class="secondary-button" type="button" id="activity-select-all">Select all</button><button class="danger-button" id="activity-delete-button" type="submit" disabled>Delete</button>
  </form>
  <div class="table-wrap"><table class="activity-table"><thead><tr><th></th><th>Question</th><th>Received</th></tr></thead><tbody id="activity-entries">
    <?php foreach ($recent as $item): ?><tr data-activity-row data-sort-date="<?= h($item['created_at']) ?>" <?= (int) $item['id'] > $previousSeenId ? 'data-new-activity' : '' ?>><td><input type="checkbox" name="ids[]" value="<?= (int) $item['id'] ?>" form="activity-bulk-form" aria-label="Select question received <?= h($item['created_at']) ?>"></td><td><?= h($item['message']) ?></td><td><?= h($item['created_at']) ?></td></tr><?php endforeach; ?>
    <tr id="activity-no-results" <?= $recent === [] ? '' : 'hidden' ?>><td colspan="3" class="empty-state">No matching questions.</td></tr>
  </tbody></table></div>
</section>
<?php admin_layout_end(); ?>
