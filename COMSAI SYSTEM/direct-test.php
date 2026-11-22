<?php
declare(strict_types=1);

require_once __DIR__ . '/config/app.php';

header('Content-Type: text/plain');

if (!extension_loaded('mysqli')) {
    exit("MySQLi extension is not enabled.");
}

mysqli_report(MYSQLI_REPORT_OFF);

$connection = new mysqli(
    app_env('DB_HOST'),
    app_env('DB_USER'),
    app_env('DB_PASS'),
    app_env('DB_NAME'),
    (int) app_env('DB_PORT', '3306')
);

if ($connection->connect_errno) {
    echo "MYSQLI CONNECTION FAILED" . PHP_EOL;
    echo "ERROR CODE: " . $connection->connect_errno . PHP_EOL;
    echo "ERROR: " . $connection->connect_error;
} else {
    echo "SUCCESS: MySQLi connection established!" . PHP_EOL;
    echo "DATABASE: " . $connection->query("SELECT DATABASE()")->fetch_row()[0];
    $connection->close();
}