<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/config/database.php';
app_security_headers();
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

start_app_session();
$admin = require_admin();
if ($admin['role'] !== 'admin') {
    http_response_code(403);
    echo json_encode(['ok' => false, 'unread' => 0]);
    exit;
}

try {
    $pdo = db();
    $query = $pdo->prepare('SELECT COUNT(*) FROM student_feedback f WHERE f.id > COALESCE((SELECT s.last_seen_feedback_id FROM admin_feedback_state s WHERE s.admin_id = :admin), 0)');
    $query->execute(['admin' => $admin['id']]);
    echo json_encode(['ok' => true, 'unread' => (int) $query->fetchColumn()]);
} catch (Throwable $error) {
    error_log('NEW COMSAI feedback notification poll failed: ' . $error->getMessage());
    http_response_code(500);
    echo json_encode(['ok' => false, 'unread' => 0]);
}
