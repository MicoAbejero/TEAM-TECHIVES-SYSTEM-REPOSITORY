<?php

declare(strict_types=1);

require_once __DIR__ . '/embeddings.php';

function chat_normalize_word(string $word): string
{
    if (preg_match('/[^\\W\\d_]+ies$/u', $word)) return mb_substr($word, 0, -3) . 'y';
    if (preg_match('/(?:ches|shes|xes|zes|sses)$/u', $word)) return mb_substr($word, 0, -2);
    if (!in_array($word, ['news','series','species','status','analysis','basis','crisis','thesis','address','process'], true)
        && preg_match('/[^s]s$/u', $word)) return mb_substr($word, 0, -1);
    return $word;
}

function chat_tokenize(string $text): array
{
    $words = preg_split('/[^\\p{L}\\p{N}]+/u', mb_strtolower($text), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    $ignored = ['what','when','where','which','who','how','does','about','tell','please','could','would','should','from','with','that','this','have','there','their','your','into','for','the','and','are','can','you','is','of','in','to','a','an','on','do','my','ccs','college','computer','studies','give','provide','information','current','currently','latest','newest','question','other','department','departmental','locate','find'];
    $words = array_map('chat_normalize_word', $words);
    return array_values(array_unique(array_filter($words, static fn(string $word): bool => mb_strlen($word) >= 3 && !in_array($word, $ignored, true))));
}

function chat_has_word(array $words, string $queryWord): bool
{
    return in_array($queryWord, $words, true);
}

function chat_is_latest_announcement_question(string $question): bool
{
    return preg_match('/\b(latest|newest|most recent|current)\b.*\b(announcement|announcements|notice|notices)\b|\b(announcement|announcements|notice|notices)\b.*\b(latest|newest|most recent|current)\b/i', $question) === 1;
}

function chat_question_needs_multiple_sources(string $question): bool
{
    if (preg_match_all('/\?/', $question) > 1 || preg_match('/[;,]/u', $question)) return true;
    if (preg_match('/,\s*[^,]+,\s*(?:and|or)\b/i', $question)) return true;
    // Topics are often joined as noun phrases, e.g. "officers and faculty members".
    return preg_match('/\b(?:and|also|additionally|in addition|as well as|plus)\b/i', $question) === 1;
}

function chat_question_parts(string $question): array
{
    $parts = preg_split('/\s+(?:and|also|additionally|in addition to|as well as|plus)\s+|[,;]+|\?+\s*/iu', trim($question), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    $parts = array_values(array_filter(array_map('trim', $parts), static fn(string $part): bool => chat_tokenize($part) !== []));
    return count($parts) > 1 ? $parts : [$question];
}

function chat_is_all_information_request(string $question): bool
{
    return preg_match('/\b(?:all|every|everything|full list|complete list)\b/i', $question) === 1;
}

function chat_question_requests_multiple_results(string $question): bool
{
    return chat_is_all_information_request($question)
        || preg_match('/\b(?:labs|laboratories|rooms|locations|facilities|events|activities|announcements)\b/i', $question) === 1;
}

function chat_retrieval_match_is_confident(int $termCount, int $titleHits, int $keywordHits, int $contentHits, ?float $semanticSimilarity): bool
{
    if ($semanticSimilarity !== null && $semanticSimilarity >= chat_embedding_min_similarity()) return true;
    if ($termCount < 1) return false;
    $matchedTerms = $titleHits + $keywordHits + $contentHits;
    $coverage = $matchedTerms / $termCount;
    if ($termCount === 1) return $titleHits === 1;
    $primaryHits = $titleHits + $keywordHits;
    if ($primaryHits > 0 && $coverage >= 0.8) return true;
    if ($primaryHits >= min(2, $termCount) && $coverage >= (2.0 / 3.0)) return true;
    $contentThreshold = max(3, (int) ceil($termCount * 0.8));
    return $primaryHits === 0 && $contentHits >= $contentThreshold && $coverage >= 0.8;
}

function chat_browse_category(PDO $pdo, ?int $categoryId, string $question): ?array
{
    if ($categoryId !== null) {
        $query = $pdo->prepare('SELECT id, name FROM categories WHERE id = :id LIMIT 1');
        $query->execute(['id' => $categoryId]);
        $category = $query->fetch();
        if ($category && (mb_strtolower(trim($question)) === mb_strtolower((string) $category['name']) || chat_is_all_information_request($question))) {
            return $category;
        }
    }

    if (!chat_is_all_information_request($question)) return null;
    $name = null;
    if (preg_match('/\bannouncements?\b|\bactivities\b|\bevents\b/i', $question)) {
        $name = 'Announcements and Activities';
    } elseif (preg_match('/\bgeneral\s+informations?\b|\babout\s+comsai\b/i', $question)) {
        $name = 'General Information';
    }
    if ($name === null) return null;
    $query = $pdo->prepare('SELECT id, name FROM categories WHERE name = :name LIMIT 1');
    $query->execute(['name' => $name]);
    $category = $query->fetch();
    return $category ?: null;
}

function chat_category_sources(PDO $pdo, array $category): array
{
    if (($category['name'] ?? '') === 'Announcements and Activities') {
        return $pdo->query("SELECT title,content,NULL AS search_terms,'Official CCS announcement' AS source_title,source_url,'Announcement' AS kind FROM announcements WHERE status='published' AND (publish_at IS NULL OR publish_at<=NOW()) AND (expiration_date IS NULL OR expiration_date>=NOW()) ORDER BY COALESCE(publish_at,created_at) DESC,id DESC")->fetchAll();
    }
    $query = $pdo->prepare("SELECT title,content,search_terms,source_title,source_url,'Knowledge base' AS kind FROM knowledge_base WHERE category_id=:category AND status='published' AND (effective_date IS NULL OR effective_date<=NOW()) AND (expiration_date IS NULL OR expiration_date>=NOW()) AND source_title IS NOT NULL AND source_title<>'' ORDER BY updated_at DESC,id DESC");
    $query->execute(['category' => (int) $category['id']]);
    return $query->fetchAll();
}

function chat_sources(PDO $pdo, string $question, ?int $categoryId = null): array
{
    // Questions asking for the latest announcement should always resolve to the
    // newest currently published announcement, regardless of keyword overlap.
    if (chat_is_latest_announcement_question($question)) {
        $query = $pdo->query("SELECT title,content,NULL AS search_terms,'Official CCS announcement' AS source_title,source_url,'Announcement' AS kind FROM announcements WHERE status='published' AND (publish_at IS NULL OR publish_at<=NOW()) AND (expiration_date IS NULL OR expiration_date>=NOW()) ORDER BY COALESCE(publish_at,created_at) DESC,id DESC LIMIT 1");
        return $query->fetchAll();
    }
    $embeddingSearchEnabled = chat_embeddings_enabled();
    $embeddingColumns = $embeddingSearchEnabled
        ? 'e.embedding_model,e.content_hash AS embedding_content_hash,e.embedding_vector'
        : 'NULL AS embedding_model,NULL AS embedding_content_hash,NULL AS embedding_vector';
    $embeddingJoin = $embeddingSearchEnabled ? ' LEFT JOIN knowledge_embeddings e ON e.knowledge_base_id=k.id' : '';
    $terms = chat_tokenize($question);
    if ($categoryId !== null) {
        $query = $pdo->prepare("SELECT k.id,k.title,k.content,k.search_terms,k.source_title,k.source_url,{$embeddingColumns},'Knowledge base' AS kind FROM knowledge_base k{$embeddingJoin} WHERE k.category_id=:category AND k.status='published' AND (k.effective_date IS NULL OR k.effective_date<=NOW()) AND (k.expiration_date IS NULL OR k.expiration_date>=NOW()) AND k.source_title IS NOT NULL AND k.source_title<>'' ORDER BY k.updated_at DESC LIMIT 100");
        $query->execute(['category'=>$categoryId]);
        $rows = $query->fetchAll();
    } else {
        $query = $pdo->query("SELECT k.id,k.title,k.content,k.search_terms,k.source_title,k.source_url,{$embeddingColumns},'Knowledge base' AS kind FROM knowledge_base k{$embeddingJoin} WHERE k.status='published' AND (k.effective_date IS NULL OR k.effective_date<=NOW()) AND (k.expiration_date IS NULL OR k.expiration_date>=NOW()) AND k.source_title IS NOT NULL AND k.source_title<>'' ORDER BY k.updated_at DESC LIMIT 1000");
        $rows = $query->fetchAll();
        $announcements = $pdo->query("SELECT title,content,NULL AS search_terms,'Official announcement' AS source_title,source_url,'Announcement' AS kind FROM announcements WHERE status='published' AND (publish_at IS NULL OR publish_at<=NOW()) AND (expiration_date IS NULL OR expiration_date>=NOW()) ORDER BY publish_at DESC LIMIT 500")->fetchAll();
        $rows = array_merge($rows, $announcements);
    }

    $multiPart = chat_question_needs_multiple_sources($question);
    $multipleResults = chat_question_requests_multiple_results($question);
    $parts = chat_question_parts($question);
    $embeddingModel = chat_embedding_model();
    $hasCurrentEmbedding = false;
    foreach ($rows as &$row) {
        $row['_embedding_vector'] = [];
        if (!$embeddingSearchEnabled
            || ($row['kind'] ?? '') !== 'Knowledge base'
            || ($row['embedding_model'] ?? '') !== $embeddingModel
            || !is_string($row['embedding_vector'] ?? null)
            || !hash_equals((string) ($row['embedding_content_hash'] ?? ''), chat_embedding_content_hash($row))) {
            continue;
        }
        $row['_embedding_vector'] = chat_unpack_embedding($row['embedding_vector']);
        if ($row['_embedding_vector'] !== []) $hasCurrentEmbedding = true;
    }
    unset($row);
    $semanticVectors = [];
    if ($hasCurrentEmbedding) {
        $semanticVectors = chat_openai_embeddings($parts) ?? [];
    }
    if ($terms === [] && $semanticVectors === []) return [];

    $candidateScores = [];
    foreach ($parts as $partIndex => $part) {
        $partTerms = chat_tokenize($part);
        $ranked = [];
        foreach ($rows as $index => $row) {
            $title = chat_tokenize((string)$row['title']);
            $keywords = chat_tokenize((string)($row['search_terms'] ?? ''));
            $content = chat_tokenize((string)$row['content']);
            $score = 0;
            $titleHits = 0;
            $keywordHits = 0;
            $contentHits = 0;
            foreach ($partTerms as $term) {
                if (chat_has_word($title, $term)) { $score += 8; $titleHits++; }
                elseif (chat_has_word($keywords, $term)) { $score += 3; $keywordHits++; }
                elseif (chat_has_word($content, $term)) { $score += 1; $contentHits++; }
            }
            $semanticSimilarity = null;
            if (($semanticVectors[$partIndex] ?? null) !== null && $row['_embedding_vector'] !== []) {
                $semanticSimilarity = chat_cosine_similarity($semanticVectors[$partIndex], $row['_embedding_vector']);
            }
            if (!chat_retrieval_match_is_confident(count($partTerms), $titleHits, $keywordHits, $contentHits, $semanticSimilarity)) continue;
            $row['_score'] = $score + (($semanticSimilarity ?? 0.0) * 12);
            $row['_matched_terms'] = $titleHits + $keywordHits + $contentHits;
            $row['_coverage'] = $partTerms === [] ? 0.0 : $row['_matched_terms'] / count($partTerms);
            $row['_semantic_similarity'] = $semanticSimilarity ?? 0.0;
            $row['_row_index'] = $index;
            $ranked[] = $row;
        }
        usort($ranked, static fn(array $a,array $b): int => ($b['_coverage'] <=> $a['_coverage']) ?: (($b['_score'] <=> $a['_score']) ?: ($b['_semantic_similarity'] <=> $a['_semantic_similarity'])));
        $matchesPerPart = $multipleResults && !$multiPart ? 10 : 1;
        foreach (array_slice($ranked, 0, $matchesPerPart) as $match) {
            $index = $match['_row_index'];
            if (!isset($candidateScores[$index])
                || $candidateScores[$index]['_coverage'] < $match['_coverage']
                || ($candidateScores[$index]['_coverage'] === $match['_coverage'] && $candidateScores[$index]['_score'] < $match['_score'])) {
                $candidateScores[$index] = $match;
            }
        }
    }
    uasort($candidateScores, static fn(array $a,array $b): int => ($b['_coverage'] <=> $a['_coverage']) ?: (($b['_score'] <=> $a['_score']) ?: ($b['_semantic_similarity'] <=> $a['_semantic_similarity'])));
    $limit = $multiPart || $multipleResults ? 10 : 1;
    return array_map(static function(array $row): array { unset($row['_score'], $row['_matched_terms'], $row['_coverage'], $row['_semantic_similarity'], $row['_row_index'], $row['_embedding_vector'], $row['embedding_model'], $row['embedding_content_hash'], $row['embedding_vector'], $row['search_terms']); return $row; }, array_slice(array_values($candidateScores), 0, $limit));
}
