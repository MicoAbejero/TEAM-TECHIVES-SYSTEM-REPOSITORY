<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/includes/embeddings.php';

if (!chat_embeddings_enabled()) {
    fwrite(STDERR, "Enable OPENAI_EMBEDDINGS_ENABLED and configure OPENAI_API_KEY before rebuilding embeddings.\n");
    exit(1);
}

try {
    $pdo = db();
    $rows = $pdo->query("SELECT id,title,content,search_terms FROM knowledge_base WHERE status='published' AND (effective_date IS NULL OR effective_date<=NOW()) AND (expiration_date IS NULL OR expiration_date>=NOW()) AND source_title IS NOT NULL AND source_title<>'' ORDER BY id")->fetchAll();
    $save = $pdo->prepare('INSERT INTO knowledge_embeddings (knowledge_base_id,embedding_model,content_hash,embedding_vector) VALUES (:id,:model,:hash,:vector) ON DUPLICATE KEY UPDATE embedding_model=VALUES(embedding_model),content_hash=VALUES(content_hash),embedding_vector=VALUES(embedding_vector)');

    foreach (array_chunk($rows, 32) as $batch) {
        $inputs = array_map('chat_embedding_text', $batch);
        $vectors = chat_openai_embeddings($inputs);
        if ($vectors === null || count($vectors) !== count($batch)) {
            throw new RuntimeException('OpenAI did not return embeddings for the whole batch. No partial batch was saved.');
        }
        $pdo->beginTransaction();
        try {
            foreach ($batch as $index => $row) {
                $packed = chat_pack_embedding($vectors[$index]);
                if ($packed === null) throw new RuntimeException('OpenAI returned an invalid embedding vector.');
                $save->execute([
                    'id' => (int) $row['id'],
                    'model' => chat_embedding_model(),
                    'hash' => chat_embedding_content_hash($row),
                    'vector' => $packed,
                ]);
            }
            $pdo->commit();
        } catch (Throwable $error) {
            if ($pdo->inTransaction()) $pdo->rollBack();
            throw $error;
        }
        fwrite(STDOUT, 'Indexed ' . count($batch) . ' published entries.' . PHP_EOL);
    }

    fwrite(STDOUT, 'Embedding rebuild complete for ' . count($rows) . ' currently published entries.' . PHP_EOL);
} catch (Throwable $error) {
    fwrite(STDERR, 'Embedding rebuild failed: ' . $error->getMessage() . PHP_EOL);
    exit(1);
}
