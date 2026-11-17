<?php

declare(strict_types=1);

function chat_greeting_answer(string $question): ?string
{
    $greeting = mb_strtolower(trim($question));
    $greeting = preg_replace('/[.!?,;:]+$/u', '', $greeting) ?? $greeting;
    if (preg_match('/^(?:hello|hi|hey|howdy|greetings|good\s+(?:morning|afternoon|evening|day)|goodday|gooday)(?:\s+(?:there|comsai|everyone))?$/u', $greeting) !== 1) {
        return null;
    }
    return 'Hello! I’m COMSAI, your CCS Student Information Assistant. How may I help you today?';
}

function chat_thank_you_answer(string $question): ?string
{
    $message = mb_strtolower(trim($question));
    $message = preg_replace('/[.!?]+$/u', '', $message) ?? $message;
    if (preg_match('/^(?:thank\s+you|thanks|many\s+thanks)(?:\s+(?:so\s+much|a\s+lot))?(?:[,\s]+(?:comsai|there))?$/u', $message) !== 1) {
        return null;
    }
    return 'You’re welcome! Let me know if you have any other questions.';
}
