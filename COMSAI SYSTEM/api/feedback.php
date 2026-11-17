<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/config/database.php';
app_security_headers();
header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

function feedback_reply(array $payload, int $status = 200): never
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
    exit;
}

try {
    start_app_session();
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') feedback_reply(['ok' => false, 'error' => 'Method not allowed.'], 405);

    $sentToken = $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '';
    if (!isset($_SESSION['csrf_token']) || !is_string($sentToken) || !hash_equals($_SESSION['csrf_token'], $sentToken)) {
        feedback_reply(['ok' => false, 'error' => 'Refresh the page and try again.'], 419);
    }

    $input = json_decode((string) file_get_contents('php://input'), true);
    if (!is_array($input)) feedback_reply(['ok' => false, 'error' => 'Invalid request.'], 400);
    $feedback = trim((string) ($input['feedback'] ?? ''));
    if ($feedback === '' || mb_strlen($feedback) > 3000) {
        feedback_reply(['ok' => false, 'error' => 'Enter feedback between 1 and 3,000 characters.'], 422);
    }

    $pdo = db();
    $ip = (string) ($_SERVER['REMOTE_ADDR'] ?? 'unknown');
    if (!check_rate_limit($pdo, 'student_feedback', $ip, 5, 600)) {
        feedback_reply(['ok' => false, 'error' => 'Too many feedback submissions. Please try again later.'], 429);
    }
    $statement = $pdo->prepare('INSERT INTO student_feedback (feedback) VALUES (:feedback)');
    $statement->execute(['feedback' => $feedback]);
    feedback_reply(['ok' => true]);
} catch (Throwable $error) {
    error_log('NEW COMSAI student feedback submission failed: ' . $error->getMessage());
    feedback_reply(['ok' => false, 'error' => 'Feedback could not be saved right now. Please try again later.'], 500);
}
