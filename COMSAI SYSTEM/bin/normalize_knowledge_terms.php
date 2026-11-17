<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/includes/search_terms.php';

$apply = in_array('--apply', $argv, true);

try {
    $pdo = db();
    $rows = $pdo->query('SELECT id,title,search_terms FROM knowledge_base ORDER BY id')->fetchAll();
    $updates = [];
    $beforeCount = 0;
    $afterCount = 0;
    $countTerms = static function (string $terms): int {
        return count(preg_split('/[,;\\r\\n]+/u', $terms, -1, PREG_SPLIT_NO_EMPTY) ?: []);
    };

    foreach ($rows as $row) {
        $previous = trim((string) ($row['search_terms'] ?? ''));
        $normalized = generated_search_terms((string) $row['title'], $previous);
        $beforeCount += $countTerms($previous);
        $afterCount += $countTerms($normalized);
        if ($normalized !== $previous) {
            $updates[] = ['id' => (int) $row['id'], 'terms' => $normalized, 'previous' => $row['search_terms']];
        }
    }

    if ($apply && $updates !== []) {
        $save = $pdo->prepare('UPDATE knowledge_base SET search_terms=:terms WHERE id=:id AND search_terms <=> :previous');
        $pdo->beginTransaction();
        try {
            foreach ($updates as $update) {
                $save->execute(['terms' => $update['terms'], 'id' => $update['id'], 'previous' => $update['previous']]);
                if ($save->rowCount() !== 1) {
                    throw new RuntimeException('An entry changed during cleanup; no partial update was committed.');
                }
            }
            $pdo->commit();
        } catch (Throwable $error) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            throw $error;
        }
    }

    fwrite(STDOUT, sprintf(
        "%s %d knowledge entries; %d search-term lists reduced from %d to %d phrases.\n",
        $apply ? 'Updated' : 'Would update',
        count($rows),
        count($updates),
        $beforeCount,
        $afterCount
    ));
    if (!$apply) fwrite(STDOUT, "No changes made. Run with --apply to save the cleanup.\n");
} catch (Throwable $error) {
    fwrite(STDERR, 'Knowledge-term cleanup failed: ' . $error->getMessage() . PHP_EOL);
    exit(1);
}
