<?php

declare(strict_types=1);

require_once __DIR__ . '/_layout.php';
$admin = require_admin();
if ($admin['role'] !== 'admin') {
    http_response_code(403);
    admin_layout_start('Student Feedback', 'feedback.php');
    echo '<div class="alert">Administrator access required.</div>';
    admin_layout_end();
    exit;
}

$pdo = db();
$previousSeen = $pdo->prepare('SELECT last_seen_feedback_id FROM admin_feedback_state WHERE admin_id = :admin');
$previousSeen->execute(['admin' => $admin['id']]);
$previousSeenId = (int) ($previousSeen->fetchColumn() ?: 0);
$latestFeedbackId = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM student_feedback')->fetchColumn();
$markSeen = $pdo->prepare('INSERT INTO admin_feedback_state (admin_id, last_seen_feedback_id) VALUES (:admin, :latest) ON DUPLICATE KEY UPDATE last_seen_feedback_id = GREATEST(last_seen_feedback_id, VALUES(last_seen_feedback_id))');
$markSeen->execute(['admin' => $admin['id'], 'latest' => $latestFeedbackId]);
$error = '';
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!verify_csrf()) {
        $error = 'Form expired. Refresh and try again.';
    } else {
        try {
            if (($_POST['action'] ?? '') !== 'bulk_delete') throw new RuntimeException('Choose the delete action.');
            $submittedIds = $_POST['ids'] ?? [];
            if (!is_array($submittedIds) || $submittedIds === []) throw new RuntimeException('Select at least one feedback entry.');
            $ids = array_values(array_unique(array_filter(
                array_map(static fn ($value) => filter_var($value, FILTER_VALIDATE_INT), $submittedIds),
                static fn ($id) => $id !== false && $id > 0
            )));
            if ($ids === []) throw new RuntimeException('Select at least one valid feedback entry.');

            $pdo->beginTransaction();
            try {
                $placeholders = implode(',', array_fill(0, count($ids), '?'));
                $existing = $pdo->prepare("SELECT id FROM student_feedback WHERE id IN ($placeholders)");
                $existing->execute($ids);
                foreach ($existing->fetchAll(PDO::FETCH_COLUMN) as $id) {
                    admin_log($pdo, $admin['id'], 'delete', 'student_feedback', (int) $id);
                }
                $delete = $pdo->prepare("DELETE FROM student_feedback WHERE id IN ($placeholders)");
                $delete->execute($ids);
                $pdo->commit();
            } catch (Throwable $exception) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                throw $exception;
            }
            $filterQuery = trim((string) ($_POST['return_q'] ?? ''));
            $sort = in_array($_POST['return_sort'] ?? '', ['latest', 'oldest', 'title'], true) ? (string) $_POST['return_sort'] : 'latest';
            $state = array_filter(['q' => $filterQuery, 'sort' => $sort === 'latest' ? '' : $sort], static fn ($value): bool => $value !== '');
            $state['saved'] = '1';
            header('Location: feedback.php?' . http_build_query($state));
            exit;
        } catch (Throwable $exception) {
            error_log('NEW COMSAI feedback delete failed: ' . $exception->getMessage());
            $error = $exception instanceof RuntimeException ? $exception->getMessage() : 'Could not delete the selected feedback.';
        }
    }
}

$q = trim((string) ($_GET['q'] ?? ''));
$sort = in_array($_GET['sort'] ?? '', ['latest', 'oldest', 'title'], true) ? (string) $_GET['sort'] : 'latest';
$filterParams = array_filter(['q' => $q, 'sort' => $sort === 'latest' ? '' : $sort], static fn ($value): bool => $value !== '');
$orderBy = match ($sort) {
    'oldest' => 'created_at ASC, id ASC',
    'title' => 'feedback ASC, id ASC',
    default => 'created_at DESC, id DESC',
};
$rows = $pdo->query('SELECT id, feedback, created_at FROM student_feedback ORDER BY ' . $orderBy)->fetchAll();
admin_layout_start('Student Feedback', 'feedback.php');
?>
<?php if ($error): ?><div class="alert" role="alert"><?= h($error) ?></div><?php elseif (isset($_GET['saved'])): ?><div class="success" role="status">Selected feedback deleted.</div><?php endif; ?>
<section class="admin-section">
  <div class="section-title"><div><h2>Student feedback</h2><p>Anonymous feedback submitted through the student interface. Do not use feedback to identify students.</p></div></div>
  <form method="get" class="filter-bar" data-feedback-search>
    <div class="field"><label for="feedback-q">Search feedback</label><div class="admin-search-input"><input id="feedback-q" name="q" value="<?= h($q) ?>" autocomplete="off" placeholder="Search feedback"><span aria-hidden="true"><svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"></circle><path d="m16 16 4 4"></path></svg></span><button class="admin-search-clear" type="button" data-search-clear aria-label="Clear search" hidden><svg viewBox="0 0 24 24" aria-hidden="true"><path d="m6 6 12 12M18 6 6 18"></path></svg></button></div></div>
    <div class="field"><label for="feedback-sort">Sort by</label><select id="feedback-sort" name="sort"><option value="latest" <?= $sort === 'latest' ? 'selected' : '' ?>>Latest</option><option value="oldest" <?= $sort === 'oldest' ? 'selected' : '' ?>>Oldest</option><option value="title" <?= $sort === 'title' ? 'selected' : '' ?>>Alphabetical</option></select></div>
  </form>
  <form id="feedback-bulk-form" method="post" class="knowledge-bulk-toolbar feedback-bulk-toolbar">
    <input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><input type="hidden" name="return_q" value="<?= h($q) ?>"><input type="hidden" name="return_sort" value="<?= h($sort) ?>"><input type="hidden" name="action" value="bulk_delete">
    <span id="feedback-selection-count" aria-live="polite">0 selected</span><button class="secondary-button" type="button" id="feedback-select-all">Select all</button><button class="danger-button" id="feedback-delete-button" type="submit" disabled>Delete</button>
  </form>
  <div class="table-wrap"><table><thead><tr><th></th><th>Feedback</th><th>Submitted</th></tr></thead><tbody id="feedback-entries">
    <?php foreach ($rows as $row): ?><tr data-feedback-row data-sort-date="<?= h($row['created_at']) ?>" <?= (int) $row['id'] > $previousSeenId ? 'data-new-feedback' : '' ?>><td><input type="checkbox" name="ids[]" value="<?= (int) $row['id'] ?>" form="feedback-bulk-form" aria-label="Select feedback submitted <?= h($row['created_at']) ?>"></td><td><?= nl2br(h($row['feedback'])) ?></td><td><?= h($row['created_at']) ?></td></tr><?php endforeach; ?>
    <tr id="feedback-no-results" <?= $rows === [] ? '' : 'hidden' ?>><td colspan="3" class="empty-state">No matching feedback.</td></tr>
  </tbody></table></div>
</section>
<?php admin_layout_end(); ?>
