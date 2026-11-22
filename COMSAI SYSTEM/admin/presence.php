<?php

declare(strict_types=1);

require_once __DIR__ . '/_layout.php';

app_security_headers();
$admin = require_admin();
header('Content-Type: application/json; charset=utf-8');

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') !== 'POST' || !verify_csrf()) {
    http_response_code(400);
    echo json_encode(['ok' => false, 'error' => 'Invalid presence request.']);
    exit;
}

try {
    $pdo = db();
    admin_presence_touch($pdo, $admin['id']);
    $activeAdmins = admin_presence_list($pdo);
    echo json_encode([
        'ok' => true,
        'admins' => array_map(static fn (array $item): array => ['name' => (string) $item['name']], $activeAdmins),
    ]);
} catch (Throwable $error) {
    error_log('NEW COMSAI admin presence endpoint failed: ' . $error->getMessage());
    http_response_code(500);
    echo json_encode(['ok' => false, 'error' => 'Presence unavailable.']);
}