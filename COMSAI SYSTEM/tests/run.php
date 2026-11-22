<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once dirname(__DIR__) . '/config/database.php';
require_once dirname(__DIR__) . '/includes/knowledge.php';
require_once dirname(__DIR__) . '/includes/chat_responses.php';
require_once dirname(__DIR__) . '/includes/search_terms.php';

$passed = 0;
$failed = 0;
$check = static function (string $name, callable $test) use (&$passed, &$failed): void {
    try {
        $test();
        ++$passed;
        fwrite(STDOUT, "PASS: {$name}\n");
    } catch (Throwable $error) {
        ++$failed;
        fwrite(STDERR, "FAIL: {$name} — {$error->getMessage()}\n");
    }
};
$assert = static function (bool $condition, string $message): void {
    if (!$condition) throw new RuntimeException($message);
};

try {
    $pdo = db();
    start_app_session();
    $required = ['admins','categories','knowledge_base','knowledge_embeddings','announcements','chat_sessions','chat_messages','admin_activity_state','activity_logs','rate_limits'];
    $tableRows = $pdo->query('SELECT table_name FROM information_schema.tables WHERE table_schema=DATABASE()')->fetchAll(PDO::FETCH_COLUMN);
    $check('database schema and citation column exist', static function () use ($assert, $required, $tableRows, $pdo): void {
        foreach ($required as $table) $assert(in_array($table, $tableRows, true), "Missing table {$table}.");
        $columns = $pdo->query("SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='chat_messages'")->fetchAll(PDO::FETCH_COLUMN);
        $assert(in_array('source_references', $columns, true), 'Chat source references column is missing.');
        $assert(in_array('response_mode', $columns, true), 'Chat response mode column is missing.');
        $categoryColumns = $pdo->query("SELECT column_name FROM information_schema.columns WHERE table_schema=DATABASE() AND table_name='categories'")->fetchAll(PDO::FETCH_COLUMN);
        $assert(in_array('show_in_student_panel', $categoryColumns, true), 'Category student panel visibility column is missing.');
    });
    $check('production requires a configured application key', static function () use ($assert): void {
        $originalEnv = getenv('APP_ENV');
        $originalKey = getenv('APP_KEY');
        putenv('APP_ENV=production');
        putenv('APP_KEY=');
        $rejected = false;
        try {
            app_secret_key();
        } catch (RuntimeException $error) {
            $rejected = str_contains($error->getMessage(), 'APP_KEY');
        } finally {
            putenv($originalEnv === false ? 'APP_ENV' : 'APP_ENV=' . $originalEnv);
            putenv($originalKey === false ? 'APP_KEY' : 'APP_KEY=' . $originalKey);
        }
        $assert($rejected, 'Production accepted a missing APP_KEY.');
    });
    $incompletePublishedKnowledge = (int) $pdo->query("SELECT COUNT(*) FROM knowledge_base WHERE status='published' AND (source_title IS NULL OR source_title='' OR search_terms IS NULL OR TRIM(search_terms)='')")->fetchColumn();
    $check('published knowledge entries have source and retrieval terms', static function () use ($assert,$incompletePublishedKnowledge): void {
        $assert($incompletePublishedKnowledge === 0, 'A published entry is missing its source title or alternate search terms.');
    });
    $categoryNames = $pdo->query('SELECT name FROM categories')->fetchAll(PDO::FETCH_COLUMN);
    $check('all requested starter categories are seeded', static function () use ($assert, $categoryNames): void {
        foreach (['Faculty and Staff','Dean and Department Personnel','CCS Council Officers','Student Organizations','Rooms and Laboratories','Announcements and Activities','Academic Requirements','Schedules and Important Dates','Academic Procedures','Department Policies','Contact Information','Frequently Asked Questions'] as $name) {
            $assert(in_array($name, $categoryNames, true), "Missing starter category {$name}.");
        }
    });
    $sample = $pdo->query("SELECT status FROM knowledge_base WHERE title='FICTIONAL TEST ONLY: Example draft'")->fetchColumn();
    $check('fictional sample is absent or remains unpublished', static function () use ($assert, $sample): void { $assert($sample === false || $sample === 'draft', 'Sample must be absent or remain a draft.'); });
    $faculty = $pdo->query("SELECT content FROM knowledge_base WHERE title='Who are the CCS faculty members?'")->fetchColumn();
    $check('faculty answer preserves full profiles and qualifications', static function () use ($assert, $faculty): void {
        foreach (['Frank Kiven B. Ablao','Trainer Methodology Level 1','Christian Drigon F. Aga','Polytechnic University of the Philippines','Juris Doctor (64 units)','Digital Tickets','System Administrator','Annabel Dichoso Nagera','Master in Education (Unit Earner)'] as $detail) {
            $assert(is_string($faculty) && str_contains($faculty, $detail), "Faculty detail is missing: {$detail}.");
        }
    });
    $pendingTitles = ['What are the requirements for [specific CCS process]?','Where can I get the form for [specific process]?','When is the student portal available or scheduled?','What are the CCS rules for using the laboratories?','What should I do if I cannot find the information I need?'];
    $pending = $pdo->prepare('SELECT status FROM knowledge_base WHERE title=:title');
    $check('unverified PDF placeholders are retained as drafts', static function () use ($assert,$pendingTitles,$pending): void {
        foreach ($pendingTitles as $title) { $pending->execute(['title'=>$title]); $assert($pending->fetchColumn()==='draft', "Placeholder is missing or published: {$title}."); }
    });

    $token = 'test' . bin2hex(random_bytes(8));
    $pdo->beginTransaction();
    $pdo->prepare('INSERT INTO categories (name,description) VALUES (:name,:description)')->execute(['name'=>'TEST '.$token,'description'=>'Temporary test category']);
    $category = (int) $pdo->lastInsertId();
    $studentPanelCategory = $pdo->prepare('SELECT COUNT(*) FROM categories WHERE id=:id AND show_in_student_panel=1');
    $setCategoryVisibility = $pdo->prepare('UPDATE categories SET show_in_student_panel=:visible WHERE id=:id');
    $check('category student panel visibility can be toggled', static function () use ($assert, $studentPanelCategory, $setCategoryVisibility, $category): void {
        $studentPanelCategory->execute(['id'=>$category]);
        $assert((int)$studentPanelCategory->fetchColumn() === 1, 'New categories should appear in the student panel by default.');
        $setCategoryVisibility->execute(['visible'=>0,'id'=>$category]);
        $studentPanelCategory->execute(['id'=>$category]);
        $assert((int)$studentPanelCategory->fetchColumn() === 0, 'Category did not hide from the student panel.');
        $setCategoryVisibility->execute(['visible'=>1,'id'=>$category]);
        $studentPanelCategory->execute(['id'=>$category]);
        $assert((int)$studentPanelCategory->fetchColumn() === 1, 'Category did not show in the student panel.');
    });
    $pdo->prepare('INSERT INTO admins (name,email,password_hash) VALUES (:name,:email,:hash)')
        ->execute(['name'=>'Activity State Test','email'=>'activity-'.$token.'@example.invalid','hash'=>password_hash(bin2hex(random_bytes(16)),PASSWORD_DEFAULT)]);
    $activityAdminId=(int)$pdo->lastInsertId();
    $activitySessionToken=hash('sha256',bin2hex(random_bytes(32)));
    $pdo->prepare('INSERT INTO chat_sessions (session_token_hash) VALUES (:token)')->execute(['token'=>$activitySessionToken]);
    $activitySessionId=(int)$pdo->lastInsertId();
    $pdo->prepare("INSERT INTO chat_messages (chat_session_id,sender,message) VALUES (:session,'student','Activity state test question')")
        ->execute(['session'=>$activitySessionId]);
    $activityMessageId=(int)$pdo->lastInsertId();
    $pdo->prepare("INSERT INTO chat_messages (chat_session_id,sender,message) VALUES (:session,'student','Second activity state test question')")
        ->execute(['session'=>$activitySessionId]);
    $secondActivityMessageId=(int)$pdo->lastInsertId();
    $activityState=$pdo->prepare('INSERT INTO admin_activity_state (admin_id,last_seen_chat_message_id) VALUES (:admin,:message) ON DUPLICATE KEY UPDATE last_seen_chat_message_id=GREATEST(last_seen_chat_message_id,VALUES(last_seen_chat_message_id))');
    $activityUnread=$pdo->prepare("SELECT COUNT(*) FROM chat_messages m WHERE m.sender='student' AND m.id>COALESCE((SELECT s.last_seen_chat_message_id FROM admin_activity_state s WHERE s.admin_id=:admin),0)");
    $check('all unseen chat activity rows are recognized until the admin views them', static function () use ($assert,$activityState,$activityUnread,$activityAdminId,$activityMessageId,$secondActivityMessageId): void {
        $activityState->execute(['admin'=>$activityAdminId,'message'=>$activityMessageId-1]);
        $activityUnread->execute(['admin'=>$activityAdminId]);
        $assert((int)$activityUnread->fetchColumn()===2,'Every unseen question was not recognized.');
        $activityState->execute(['admin'=>$activityAdminId,'message'=>$secondActivityMessageId]);
        $activityUnread->execute(['admin'=>$activityAdminId]);
        $assert((int)$activityUnread->fetchColumn()===0,'Seen questions remained unread.');
    });
    $insert = $pdo->prepare('INSERT INTO knowledge_base (category_id,title,content,source_title,effective_date,expiration_date,status) VALUES (:category,:title,:content,:source,:effective,:expires,:status)');
    $fixtures = [];
    foreach ([
        ['current', null, '2099-12-31', 'published', 'Verified test source'],
        ['future', '2099-01-01', '2099-12-31', 'published', 'Verified test source'],
        ['expired', null, '2000-01-01', 'published', 'Verified test source'],
        ['draft', null, '2099-12-31', 'draft', 'Verified test source'],
        ['unsourced', null, '2099-12-31', 'published', ''],
    ] as [$label,$effective,$expires,$status,$source]) {
        $insert->execute(['category'=>$category,'title'=>'AUTOMATED '.$token.' '.$label,'content'=>'Keyword '.$token.' test evidence.','source'=>$source,'effective'=>$effective,'expires'=>$expires,'status'=>$status]);
        $fixtures[$label] = (int) $pdo->lastInsertId();
    }
    $announcementToken = 'notice' . bin2hex(random_bytes(8));
    $announcement = $pdo->prepare("INSERT INTO announcements (title,content,publish_at,expiration_date,status) VALUES (:title,:content,NOW(),:expires,'published')");
    $announcement->execute(['title'=>'AUTOMATED '.$announcementToken,'content'=>'Keyword '.$announcementToken.' announcement evidence.','expires'=>'2099-12-31 23:59:59']);
    $announcementId = (int) $pdo->lastInsertId();
    $multiSourceFixtures = [
        ['CCS faculty contact details', 'The faculty contact is listed in this verified test entry.'],
        ['Laboratory opening hours', 'The laboratory hours are listed in this verified test entry.'],
        ['CCS Council Officers roster', 'Verified names of the current CCS Council officers.'],
        ['CCS faculty members', 'Verified names of the current CCS faculty members.'],
    ];
    $multiSourceInsert = $pdo->prepare("INSERT INTO knowledge_base (category_id,title,content,source_title,status) VALUES (:category,:title,:content,'Verified test source','published')");
    foreach ($multiSourceFixtures as [$title, $content]) {
        $multiSourceInsert->execute(['category'=>$category,'title'=>$title,'content'=>$content]);
    }
    $multiSourceInsert->execute([
        'category'=>$category,
        'title'=>'Generic department question wording',
        'content'=>'This text describes generic questions for other departments but no verified student service details.',
    ]);
    $pdo->prepare("INSERT INTO knowledge_base (category_id,title,content,search_terms,source_title,status) VALUES (:category,'General faculty support information','This entry contains a broad faculty contact reference.','faculty, contact','Verified test source','published')")
        ->execute(['category'=>$category]);
    $labInsert = $pdo->prepare("INSERT INTO knowledge_base (category_id,title,content,search_terms,source_title,status) VALUES (:category,:title,:content,:terms,'Verified test source','published')");
    foreach ([
        ['Test Main Lab location', 'Test Main Lab is on the second floor in Room 207.', 'testmain, lab, location, room, 207'],
        ['Test Key Lab location', 'Test Key Lab is on the second floor in Room 212.', 'testkey, lab, location, room, 212'],
        ['Test Annex Lab location', 'Test Annex Lab is on the second floor in Room 203.', 'testannex, lab, location, room, 203'],
    ] as [$title,$content,$terms]) {
        $labInsert->execute(['category'=>$category,'title'=>$title,'content'=>$content,'terms'=>$terms]);
    }
    foreach ([
        ['Computer Main Laboratory location', 'The computer Main Laboratory is in Room 207.'],
        ['Computer Key Laboratory location', 'The computer Key Laboratory is in Room 212.'],
        ['Computer Annex Laboratory location', 'The computer Annex Laboratory is in Room 203.'],
    ] as [$title,$content]) {
        $multiSourceInsert->execute(['category'=>$category,'title'=>$title,'content'=>$content]);
    }

    $check('retrieval filters drafts, expired, future, and unsourced knowledge', static function () use ($pdo,$assert,$token,$announcementToken,$fixtures,$announcementId): void {
        $rows=chat_sources($pdo,$token);$ids=array_column($rows,'title');
        $assert(in_array('AUTOMATED '.$token.' current',$ids,true),'Current published sourced knowledge was not retrieved.');
        $announcementRows=chat_sources($pdo,$announcementToken);$announcementTitles=array_column($announcementRows,'title');
        $assert(in_array('AUTOMATED '.$announcementToken,$announcementTitles,true),'Current published announcement was not retrieved.');
        foreach(['future','expired','draft','unsourced'] as $label) $assert(!in_array('AUTOMATED '.$token.' '.$label,$ids,true),"Ineligible {$label} item was retrieved.");
        $assert(count(array_filter($rows,static fn(array $row):bool=>str_contains($row['title'],'AUTOMATED '.$token)))>=1,'Expected the knowledge fixture.');
    });
    $check('announcement topic browse returns every current published announcement', static function () use ($pdo,$assert,$announcementToken): void {
        $category=chat_browse_category($pdo,null,'Show all announcements and activities');
        $assert(($category['name']??'')==='Announcements and Activities','Announcement browse request did not identify its category.');
        $titles=array_column(chat_category_sources($pdo,$category),'title');
        $assert(in_array('AUTOMATED '.$announcementToken,$titles,true),'The current published announcement was not included.');
        $assert(!in_array('What is the latest announcement?',$titles,true),'The knowledge-base routing helper was shown as an announcement.');
    });
    $check('general information topic browse returns all published category entries', static function () use ($pdo,$assert): void {
        $category=chat_browse_category($pdo,null,'Show me all general information');
        $assert(($category['name']??'')==='General Information','General information browse request did not identify its category.');
        $titles=array_column(chat_category_sources($pdo,$category),'title');
        $assert(in_array('What is COMSAI?',$titles,true),'COMSAI overview was not included.');
        $assert(in_array('What information can I ask COMSAI about?',$titles,true),'Supported topic overview was not included.');
    });
    $check('multi-part questions retrieve matching sources for each part', static function () use ($pdo,$assert,$category): void {
        $rows = chat_sources($pdo, 'Who is the CCS faculty contact and what are the laboratory opening hours?', $category);
        $titles = array_column($rows, 'title');
        $assert(in_array('CCS faculty contact details', $titles, true), 'Faculty contact source was not retrieved.');
        $assert(in_array('Laboratory opening hours', $titles, true), 'Laboratory hours source was not retrieved.');
    });
    $check('combined topics retrieve both sources with varied natural wording', static function () use ($pdo,$assert,$category): void {
        foreach ([
            'Can you tell me about the CCS council officers and faculty members?',
            'Please list CCS faculty members, and council officers.',
        ] as $question) {
            $titles = array_column(chat_sources($pdo, $question, $category), 'title');
            $assert(in_array('CCS Council Officers roster', $titles, true), 'Council officers source was not retrieved.');
            $assert(in_array('CCS faculty members', $titles, true), 'Faculty members source was not retrieved.');
        }
    });
    $check('single-part questions return only the best matching source', static function () use ($pdo,$assert,$category): void {
        $rows = chat_sources($pdo, 'Who is the CCS faculty contact?', $category);
        $assert(count($rows) === 1, 'A single-part question returned multiple sources.');
        $assert(($rows[0]['title'] ?? '') === 'CCS faculty contact details', 'The most specific source was not ranked first.');
    });
    $check('a plural roster request returns only its best matching source', static function () use ($pdo,$assert,$category): void {
        $rows = chat_sources($pdo, 'Give me the list of CCS council officers', $category);
        $assert(count($rows) === 1, 'A request for one roster returned multiple knowledge entries.');
        $assert(($rows[0]['title'] ?? '') === 'CCS Council Officers roster', 'The council officers roster was not ranked first.');
    });
    $check('comma-separated questions retrieve each named item', static function () use ($pdo,$assert,$category): void {
        $rows = chat_sources($pdo, 'Where can I locate these testmain lab, testkey lab, and testannex lab?', $category);
        $titles = array_column($rows, 'title');
        foreach (['Test Main Lab location','Test Key Lab location','Test Annex Lab location'] as $title) {
            $assert(in_array($title, $titles, true), "Missing source for {$title}.");
        }
    });
    $check('plural location questions retrieve every matching laboratory', static function () use ($pdo,$assert): void {
        $rows = chat_sources($pdo, 'Where can I locate computer laboratories?');
        $titles = array_column($rows, 'title');
        foreach (['Computer Main Laboratory location','Computer Key Laboratory location','Computer Annex Laboratory location'] as $title) {
            $assert(in_array($title, $titles, true), "Missing source for {$title}.");
        }
        $assert(!in_array('What information can I ask COMSAI about?', $titles, true), 'A general overview with only a weak keyword match was included.');
        $assert(!in_array('Where can I find the CCS Dean?', $titles, true), 'A Dean location with only a weak keyword match was included.');
    });
    $check('retrieval confidence rejects weak keyword-only matches', static function () use ($assert): void {
        $assert(!chat_retrieval_match_is_confident(3, 0, 1, 0, null), 'A single keyword match was treated as sufficient evidence.');
        $assert(!chat_retrieval_match_is_confident(2, 1, 0, 0, null), 'A partial title overlap was treated as sufficient evidence.');
        $assert(chat_retrieval_match_is_confident(2, 1, 0, 1, null), 'A title match supported by verified content was rejected.');
        $assert(chat_retrieval_match_is_confident(3, 0, 2, 0, null), 'A strong alternate-keyword match was rejected.');
        $assert(!chat_retrieval_match_is_confident(3, 0, 0, 2, null), 'A partial content-only match was treated as sufficient evidence.');
        $assert(!chat_retrieval_match_is_confident(0, 0, 0, 0, null), 'A question with no meaningful terms was treated as a match.');
        $threshold = chat_embedding_min_similarity();
        $assert(chat_retrieval_match_is_confident(3, 0, 0, 0, min(1.0, $threshold + 0.01)), 'A strong semantic match was rejected.');
        if ($threshold > 0.1) $assert(!chat_retrieval_match_is_confident(3, 0, 0, 0, $threshold - 0.1), 'A weak semantic match was accepted.');
    });
    $check('generic other-department questions do not retrieve unrelated keyword overlap', static function () use ($pdo,$assert,$category): void {
        $assert(chat_sources($pdo, 'Question for other departments', $category) === [], 'A generic phrase match returned unrelated verified information.');
    });
    $check('embeddings round-trip and compare semantic vectors safely', static function () use ($assert): void {
        $packed = chat_pack_embedding([1.0, 0.0, -1.0]);
        $assert(is_string($packed), 'A valid embedding was not packed.');
        $unpacked = chat_unpack_embedding($packed);
        $assert(count($unpacked) === 3 && abs($unpacked[0] - 1.0) < 0.0001, 'Embedding packing changed vector values.');
        $similarity = chat_cosine_similarity([1.0, 0.0], [1.0, 0.0]);
        $assert($similarity !== null && abs($similarity - 1.0) < 0.0001, 'Identical vectors were not recognized as similar.');
        $assert(chat_cosine_similarity([1.0, 0.0], [0.0, 1.0]) === 0.0, 'Orthogonal vectors were not recognized as unrelated.');
        $assert(chat_cosine_similarity([1.0], [1.0, 0.0]) === null, 'Mismatched vector dimensions were accepted.');
        $before = chat_embedding_content_hash(['title'=>'Entry','search_terms'=>'alias','content'=>'Old answer']);
        $after = chat_embedding_content_hash(['title'=>'Entry','search_terms'=>'alias','content'=>'Updated answer']);
        $assert($before !== $after, 'An edited answer did not invalidate its previous embedding.');
    });
    $check('search terms use focused title words and administrator-provided aliases', static function () use ($assert): void {
        $terms = generated_search_terms('Council Officers roster', 'student council, who are the officers?');
        $assert(str_contains($terms, 'council') && str_contains($terms, 'officers') && str_contains($terms, 'who are the officers?'), 'Expected title terms or manual aliases were omitted.');
        $phrases = explode(', ', $terms);
        $assert(count($phrases) <= 15, 'Search terms exceeded the phrase limit.');
        foreach ($phrases as $phrase) {
            $assert(count(preg_split('/\s+/u', trim($phrase), -1, PREG_SPLIT_NO_EMPTY) ?: []) >= 2, 'A one-word search term was retained.');
        }
        $scheduleTerms = generated_search_terms('What does A or B mean in my class schedule?');
        $assert(str_contains($scheduleTerms, 'face to face and online schedule rotation'), 'A useful schedule query alias was not added.');
        $assert(validate_manual_search_terms('student, class schedule', 'Class schedule') !== null, 'A one-word manual term was not rejected.');
        $assert(validate_manual_search_terms('student council, where is the council?', 'CCS Council Officers') === null, 'Useful multiword aliases were rejected.');
    });
    $check('unmatched question produces no verified results', static function () use ($pdo,$assert): void { $assert(chat_sources($pdo,'qzv-no-match-'.bin2hex(random_bytes(6)))===[],'An unmatched query returned results.'); });

    $chatToken=hash('sha256',bin2hex(random_bytes(32)));
    $pdo->prepare('INSERT INTO chat_sessions (session_token_hash) VALUES (:token)')->execute(['token'=>$chatToken]);
    $session=(int)$pdo->lastInsertId();
    $refs=json_encode([['title'=>'Test source','url'=>'https://example.org/source']]);
    $pdo->prepare("INSERT INTO chat_messages (chat_session_id,sender,message,source_references,response_mode) VALUES (:session,'assistant','Test answer',:refs,'ai-general')")->execute(['session'=>$session,'refs'=>$refs]);
    $stored=$pdo->prepare('SELECT source_references,response_mode FROM chat_messages WHERE chat_session_id=:id');$stored->execute(['id'=>$session]);
    $check('chat citations and response labels are retained with anonymous session messages', static function () use ($assert,$stored): void { $row=$stored->fetch();$value=json_decode((string)$row['source_references'],true);$assert(($value[0]['title']??'')==='Test source','Citation did not round-trip.');$assert($row['response_mode']==='ai-general','Response mode did not round-trip.'); });

    $check('HTML output escaping works', static function () use ($assert): void { $assert(h('<script>')==='&lt;script&gt;','HTML was not escaped.'); });
    $check('chat responds to thank-you messages', static function () use ($assert): void {
        $assert(chat_thank_you_answer('Thank you') === 'You’re welcome! Let me know if you have any other questions.', 'A basic thank-you did not receive a response.');
        $assert(chat_thank_you_answer('Thanks a lot, COMSAI!') !== null, 'A thank-you addressed to COMSAI was not recognized.');
        $assert(chat_thank_you_answer('Thank you for the laboratory hours?') === null, 'A question beginning with thank-you was mistaken for a standalone thank-you.');
    });
    $csrf=csrf_token();$_POST['_csrf']=$csrf;
    $check('CSRF tokens validate securely', static function () use ($assert): void { $assert(verify_csrf(),'Valid token rejected.');$_POST['_csrf']='invalid';$assert(!verify_csrf(),'Invalid token accepted.');unset($_POST['_csrf']); });
    $scope='test-'.$token;
    $check('database rate limiting stops excess requests', static function () use ($pdo,$assert,$scope): void { $assert(check_rate_limit($pdo,$scope,'anonymous',2,60),'First request blocked.');$assert(check_rate_limit($pdo,$scope,'anonymous',2,60),'Second request blocked.');$assert(!check_rate_limit($pdo,$scope,'anonymous',2,60),'Excess request allowed.'); });
} catch (Throwable $error) {
    ++$failed;
    fwrite(STDERR, 'FAIL: test setup — '.$error->getMessage()."\n");
} finally {
    if (isset($pdo) && $pdo instanceof PDO && $pdo->inTransaction()) $pdo->rollBack();
}

fwrite(STDOUT, sprintf("\n%d passed, %d failed. Test fixtures were rolled back.\n",$passed,$failed));
exit($failed===0?0:1);
