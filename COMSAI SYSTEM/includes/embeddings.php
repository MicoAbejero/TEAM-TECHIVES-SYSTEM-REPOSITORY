<?php

declare(strict_types=1);

function chat_embeddings_enabled(): bool
{
    return app_env('OPENAI_EMBEDDINGS_ENABLED', '0') === '1'
        && app_env('OPENAI_API_KEY') !== ''
        && function_exists('curl_init');
}

function chat_embedding_model(): string
{
    $model = trim(app_env('OPENAI_EMBEDDING_MODEL', 'text-embedding-3-small'));
    return $model !== '' ? $model : 'text-embedding-3-small';
}

function chat_embedding_min_similarity(): float
{
    $value = app_env('OPENAI_EMBEDDING_MIN_SIMILARITY', '0.60');
    if (!is_numeric($value)) return 0.60;
    return max(0.0, min(1.0, (float) $value));
}

function chat_embedding_text(array $entry): string
{
    $text = "Title: " . trim((string) ($entry['title'] ?? ''))
        . "\nAlternate terms: " . trim((string) ($entry['search_terms'] ?? ''))
        . "\nVerified answer: " . trim((string) ($entry['content'] ?? ''));
    return mb_substr($text, 0, 20000);
}

function chat_embedding_content_hash(array $entry): string
{
    return hash('sha256', implode("\0", [
        (string) ($entry['title'] ?? ''),
        (string) ($entry['search_terms'] ?? ''),
        (string) ($entry['content'] ?? ''),
    ]));
}

function chat_openai_embeddings(array $inputs): ?array
{
    if ($inputs === [] || !chat_embeddings_enabled()) return null;
    foreach ($inputs as $input) {
        if (!is_string($input) || trim($input) === '') return null;
    }

    $payload = json_encode([
        'model' => chat_embedding_model(),
        'input' => array_values($inputs),
        'encoding_format' => 'float',
    ]);
    if (!is_string($payload)) {
        error_log('NEW COMSAI embedding request could not be encoded.');
        return null;
    }

    $curl = curl_init('https://api.openai.com/v1/embeddings');
    curl_setopt_array($curl, [
        CURLOPT_POST => true,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CONNECTTIMEOUT => 5,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . app_env('OPENAI_API_KEY'),
        ],
        CURLOPT_POSTFIELDS => $payload,
    ]);
    $body = curl_exec($curl);
    $status = (int) curl_getinfo($curl, CURLINFO_RESPONSE_CODE);
    curl_close($curl);
    if (!is_string($body) || $status < 200 || $status >= 300) {
        error_log('NEW COMSAI embedding request failed with HTTP status ' . $status);
        return null;
    }

    $data = json_decode($body, true);
    $items = $data['data'] ?? null;
    if (!is_array($items)) {
        error_log('NEW COMSAI embedding response was invalid.');
        return null;
    }
    $vectors = array_fill(0, count($inputs), null);
    foreach ($items as $item) {
        $index = filter_var($item['index'] ?? null, FILTER_VALIDATE_INT);
        $vector = $item['embedding'] ?? null;
        if ($index === false || $index === null || $index < 0 || $index >= count($inputs) || !is_array($vector)) {
            error_log('NEW COMSAI embedding response contained an invalid vector.');
            return null;
        }
        $packed = chat_pack_embedding($vector);
        if ($packed === null) {
            error_log('NEW COMSAI embedding response contained an invalid vector.');
            return null;
        }
        $vectors[$index] = $vector;
    }
    foreach ($vectors as $vector) {
        if (!is_array($vector)) {
            error_log('NEW COMSAI embedding response omitted a vector.');
            return null;
        }
    }
    return $vectors;
}

function chat_pack_embedding(array $vector): ?string
{
    $values = [];
    foreach ($vector as $value) {
        if (!is_numeric($value) || !is_finite((float) $value)) return null;
        $values[] = (float) $value;
    }
    if ($values === []) return null;
    return pack('g*', ...$values);
}

function chat_unpack_embedding(string $packed): array
{
    if ($packed === '' || strlen($packed) % 4 !== 0) return [];
    $values = unpack('g*', $packed);
    return $values === false ? [] : array_values($values);
}

function chat_cosine_similarity(array $left, array $right): ?float
{
    if ($left === [] || count($left) !== count($right)) return null;
    $dot = 0.0;
    $leftMagnitude = 0.0;
    $rightMagnitude = 0.0;
    foreach ($left as $index => $leftValue) {
        $leftValue = (float) $leftValue;
        $rightValue = (float) $right[$index];
        if (!is_finite($leftValue) || !is_finite($rightValue)) return null;
        $dot += $leftValue * $rightValue;
        $leftMagnitude += $leftValue * $leftValue;
        $rightMagnitude += $rightValue * $rightValue;
    }
    if ($leftMagnitude <= 0.0 || $rightMagnitude <= 0.0) return null;
    return $dot / sqrt($leftMagnitude * $rightMagnitude);
}
