<?php

declare(strict_types=1);

function validate_manual_search_terms(string $manual, string $title): ?string
{
    $phrases = preg_split('/[,;\\r\\n]+/u', $manual, -1, PREG_SPLIT_NO_EMPTY) ?: [];
    $seen = [];
    foreach ($phrases as $phrase) {
        $phrase = trim(preg_replace('/\\s+/u', ' ', $phrase) ?? $phrase);
        if ($phrase === '' || mb_strtolower($phrase) === mb_strtolower(trim($title))) continue;
        $key = mb_strtolower($phrase);
        if (isset($seen[$key])) continue;
        $seen[$key] = true;
        $words = preg_split('/\\s+/u', $phrase, -1, PREG_SPLIT_NO_EMPTY) ?: [];
        if (count($words) < 2) return 'Each alternate search term must contain at least two words. Use a relevant phrase or sample student question.';
        if (preg_match('/\\b(?:https?|www)\\b|\\.com\\b/i', $phrase)) return 'Use relevant keywords or sample questions, not URLs.';
        if (count($seen) > 14) return 'Use no more than 14 alternate phrases or sample questions; the entry title is added automatically.';
    }
    return null;
}

function generated_search_terms(string $title, string $manual = ''): string
{
    $knownAliases = [
        'What does A or B mean in my class schedule?' => [
            'A and B class schedule meaning',
            'what is A or B class modality',
            'face to face and online schedule rotation',
        ],
        'Who should I contact about portal settlement?' => [
            'student portal balance help',
            'who can help with portal payment',
            'where can I ask about an outstanding balance',
        ],
        'Where can I pay my department fee?' => [
            'CCS department fee payment options',
            'where to pay department dues',
            'how to pay the CCS department fee',
        ],
        'Who should I contact about my grades?' => [
            'ask a professor about subject grades',
            'who handles grade questions',
            'contact an instructor about my grade',
        ],
        'Who should I contact if I have an INC grade?' => [
            'ask a professor about an incomplete grade',
            'who handles INC completion',
            'contact an instructor about INC requirements',
        ],
        'Who should I contact if my concern is not listed?' => [
            'who can help with another CCS concern',
            'ask about an unlisted department issue',
            'contact a CCS council adviser',
        ],
        'How do I know my class schedule?' => [
            'view my class timetable',
            'find subject times and room assignments',
            'where to see my schedule in the student portal',
        ],
    ];
    $candidates = array_merge(
        [$title],
        preg_split('/[,;\\r\\n]+/u', $manual, -1, PREG_SPLIT_NO_EMPTY) ?: [],
        $knownAliases[$title] ?? []
    );
    $terms = [];
    $seen = [];
    foreach ($candidates as $candidate) {
        $term = trim(preg_replace('/\\s+/u', ' ', $candidate) ?? $candidate);
        if ($term === '' || preg_match('/\\b(?:https?|www)\\b|\\.com\\b/i', $term) || preg_match('/\\p{L}/u', $term) !== 1) continue;
        $words = preg_split('/\\s+/u', $term, -1, PREG_SPLIT_NO_EMPTY) ?: [];
        if (count($words) < 2) continue;
        $key = mb_strtolower($term);
        if (isset($seen[$key])) continue;
        $nextTerms = array_merge($terms, [$term]);
        if (count($nextTerms) > 15 || mb_strlen(implode(', ', $nextTerms)) > 4000) continue;
        $terms = $nextTerms;
        $seen[$key] = true;
    }
    return implode(', ', $terms);
}
