<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/includes/site_settings.php';

function admin_nav_icon(string $name): string
{
    $paths = [
        'dashboard' => '<rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>',
        'knowledge' => '<path d="M4 5.5A2.5 2.5 0 0 1 6.5 3H20v17H6.5A2.5 2.5 0 0 0 4 22z"/><path d="M4 5.5v14A2.5 2.5 0 0 1 6.5 17H20M8 7h8M8 11h8"/>',
        'announcements' => '<path d="M4 14V9a2 2 0 0 1 2-2h3l9-4v17l-9-4H6a2 2 0 0 1-2-2z"/><path d="m8 16 2 5h4l-2.2-4.3M21 9v5"/>',
        'categories' => '<path d="M3 6a2 2 0 0 1 2-2h5l2 2h7a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><path d="M3 9h18"/>',
        'activity' => '<path d="M3 12h4l3-8 4 16 3-8h4"/>',
        'feedback' => '<path d="M21 11.5a8.5 8.5 0 0 1-8.5 8.5 8.4 8.4 0 0 1-4-.99L3 21l1.99-5.5A8.5 8.5 0 1 1 21 11.5Z"/><path d="M8 12h.01M12 12h.01M16 12h.01"/>',
        'account' => '<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>',
        'student' => '<rect x="3" y="4" width="18" height="13" rx="2"/><path d="M8 21h8M12 17v4M8 9l2 2 5-5"/>',
        'logout' => '<path d="M10 17l5-5-5-5M15 12H3"/><path d="M12 3h6a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-6"/>',
        'chevron' => '<path d="m9 18 6-6-6-6"/>',
    ];
    return '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">' . ($paths[$name] ?? '') . '</svg>';
}

function admin_presence_prepare(PDO $pdo): void
{
    static $prepared = false;
    if ($prepared) {
        return;
    }
    $pdo->exec('CREATE TABLE IF NOT EXISTS admin_presence (admin_id INT NOT NULL PRIMARY KEY, last_seen_at DATETIME NOT NULL)');
    $prepared = true;
}

function admin_presence_touch(PDO $pdo, int $adminId): void
{
    admin_presence_prepare($pdo);
    $statement = $pdo->prepare('INSERT INTO admin_presence (admin_id, last_seen_at) VALUES (:admin, NOW()) ON DUPLICATE KEY UPDATE last_seen_at = NOW()');
    $statement->execute(['admin' => $adminId]);
}

function admin_presence_list(PDO $pdo): array
{
    admin_presence_prepare($pdo);
    $statement = $pdo->prepare("SELECT a.id, a.name, a.email, p.last_seen_at FROM admins a INNER JOIN admin_presence p ON p.admin_id = a.id WHERE a.is_active = 1 AND p.last_seen_at >= DATE_SUB(NOW(), INTERVAL 5 MINUTE) ORDER BY a.name ASC");
    $statement->execute();
    return $statement->fetchAll();
}

function admin_layout_start(string $title, string $active): array
{
    app_security_headers();
    $admin = require_admin();
    $activeAdmins = [];
    try {
        $presencePdo = db();
        admin_presence_touch($presencePdo, $admin['id']);
        $activeAdmins = admin_presence_list($presencePdo);
    } catch (Throwable $error) {
        error_log('NEW COMSAI admin presence update failed: ' . $error->getMessage());
    }
    $studentInterfaceEnabled = student_interface_enabled(db());
    $hasUnreadFeedback = false;
    if ($admin['role'] === 'admin') {
        try {
            $unread = db()->prepare('SELECT COUNT(*) FROM student_feedback f WHERE f.id > COALESCE((SELECT s.last_seen_feedback_id FROM admin_feedback_state s WHERE s.admin_id = :admin), 0)');
            $unread->execute(['admin' => $admin['id']]);
            $hasUnreadFeedback = (int) $unread->fetchColumn() > 0;
        } catch (Throwable $error) {
            error_log('NEW COMSAI feedback notification check failed: ' . $error->getMessage());
        }
    }
    $hasUnreadActivity = false;
    if ($admin['role'] === 'admin') {
        try {
            $unread = db()->prepare("SELECT EXISTS(SELECT 1 FROM chat_messages m WHERE m.sender='student' AND m.id > COALESCE((SELECT s.last_seen_chat_message_id FROM admin_activity_state s WHERE s.admin_id = :admin), 0))");
            $unread->execute(['admin' => $admin['id']]);
            $hasUnreadActivity = (bool) $unread->fetchColumn();
        } catch (Throwable $error) {
            error_log('NEW COMSAI activity notification check failed: ' . $error->getMessage());
        }
    }
    $nav = [
        'index.php' => ['Dashboard', 'dashboard'],
        'knowledge.php' => ['Knowledge base', 'knowledge'],
        'announcements.php' => ['Announcements', 'announcements'],
        'categories.php' => ['Categories', 'categories'],
        'activity.php' => ['Chatbot activity', 'activity'],
        'feedback.php' => ['Student Feedback', 'feedback'],
        'account.php' => ['Administrator account', 'account'],
    ];
    ?><!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><?= h($title) ?> | COMSAI</title><link rel="icon" type="image/png" href="../assets/comsai-icon.png?v=20261028-1"><link rel="stylesheet" href="../assets/css/admin.css?v=20261111-5"><link rel="stylesheet" href="../assets/css/admin-overrides.css?v=20261122-4"></head><body class="admin-page"><header class="admin-topbar"><button class="menu-toggle" type="button" aria-label="Toggle navigation" aria-expanded="false">&#9776;</button></header><div class="admin-shell"><aside class="admin-sidebar"><a class="admin-brand" href="index.php" aria-label="COMSAI dashboard"><img class="admin-mark" src="../assets/comsai-icon.png" alt=""><span><strong>COMSAI</strong><small>CCS information management</small></span></a><nav aria-label="Administrator navigation">
    <?php foreach ($nav as $route => [$label, $icon]): if (in_array($route, ['categories.php', 'feedback.php'], true) && $admin['role'] !== 'admin') continue; ?>
      <a class="nav-link <?= $active === $route ? 'active' : '' ?>" href="<?= h($route) ?>" <?= $route === 'activity.php' ? 'data-activity-nav' : ($route === 'feedback.php' ? 'data-feedback-nav' : '') ?>><span class="nav-icon"><?= admin_nav_icon($icon) ?></span><span class="nav-label"><?= h($label) ?></span><?php if ($route === 'activity.php'): ?><span class="nav-notification-dot" data-activity-notification <?= $hasUnreadActivity ? '' : 'hidden' ?> aria-hidden="true" title="New chatbot activity"></span><?php elseif ($route === 'feedback.php'): ?><span class="nav-notification-dot" data-feedback-notification <?= $hasUnreadFeedback ? '' : 'hidden' ?> aria-hidden="true" title="New student feedback"></span><?php endif; ?><span class="nav-chevron"><?= admin_nav_icon('chevron') ?></span></a>
    <?php endforeach; ?>
    <details class="student-interface-menu"><summary class="nav-link"><span class="nav-icon"><?= admin_nav_icon('student') ?></span><span class="nav-label">Student interface</span><span class="nav-chevron nav-menu-more" aria-hidden="true"><?= admin_nav_icon('chevron') ?></span></summary><div class="nav-submenu"><a href="../?new_chat=1" target="_blank" rel="noopener">Open Student Interface <span aria-hidden="true">&#8599;</span></a><span class="nav-menu-status <?= $studentInterfaceEnabled ? 'is-enabled' : 'is-disabled' ?>" data-interface-status aria-live="polite"><?= $studentInterfaceEnabled ? 'Enabled' : 'Disabled' ?></span><?php if ($admin['role'] === 'admin'): ?><form method="post" action="student_interface.php" data-student-interface-form><input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><button type="submit" name="action" value="enable" <?= $studentInterfaceEnabled ? 'disabled' : '' ?>>Enable Student Interface</button></form><form method="post" action="student_interface.php" data-student-interface-form><input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><button type="submit" name="action" value="disable" <?= !$studentInterfaceEnabled ? 'disabled' : '' ?>>Disable Interface</button></form><?php endif; ?></div></details>
    </nav><form method="post" action="../logout.php" class="logout-form" data-confirm="Are you sure you want to log out?"><input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><button class="nav-link logout-link" type="submit"><span class="nav-icon"><?= admin_nav_icon('logout') ?></span><span class="nav-label">Log out</span><span class="nav-chevron"><?= admin_nav_icon('chevron') ?></span></button></form></aside><main class="admin-content"><div class="content-heading"><div><p class="eyebrow">ADMINISTRATION</p><h1><?= h($title) ?></h1></div><div class="admin-account-panel"><div class="admin-identity"><?= h($admin['name']) ?> <small><?= h($admin['role']) ?></small></div><div class="admin-presence-wrap" data-admin-presence data-csrf="<?= h(csrf_token()) ?>"><button class="admin-presence-toggle" type="button" data-admin-presence-toggle aria-expanded="false"><span>See active users</span></button><span class="presence-dot presence-dot-outside" aria-hidden="true"></span><div class="admin-presence-panel" data-admin-presence-panel hidden><strong>Active administrators</strong><ul data-admin-presence-list><?php foreach ($activeAdmins as $activeAdmin): ?><li><?= h($activeAdmin['name']) ?></li><?php endforeach; ?></ul></div></div></div></div>
    <?php return $admin;
}

function admin_layout_end(): void
{
    ?></main></div><script src="../assets/js/admin.js?v=20261122-1" defer></script></body></html><?php
}

function admin_log(PDO $pdo, int $adminId, string $action, string $entity, ?int $entityId = null): void
{
    $statement = $pdo->prepare('INSERT INTO activity_logs (admin_id, action, entity_type, entity_id) VALUES (:admin, :action, :entity, :id)');
    $statement->execute(['admin' => $adminId, 'action' => $action, 'entity' => $entity, 'id' => $entityId]);
}
