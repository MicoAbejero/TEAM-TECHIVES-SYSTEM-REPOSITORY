<?php

declare(strict_types=1);

require_once __DIR__ . '/_layout.php';
$admin = require_admin();
if ($admin['role'] !== 'admin') { http_response_code(403); exit('Administrator access required.'); }
$pdo = db();
$error = '';

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    if (!verify_csrf()) {
        $error = 'Form expired. Refresh and try again.';
    } else try {
        $action = (string)($_POST['action'] ?? 'save');
        if (in_array($action, ['bulk_delete', 'bulk_show_quick_action', 'bulk_hide_quick_action'], true)) {
            $submittedIds = $_POST['ids'] ?? [];
            if (!is_array($submittedIds) || $submittedIds === []) throw new RuntimeException('Select at least one category.');
            $ids = array_values(array_unique(array_filter(array_map(static fn($value) => filter_var($value, FILTER_VALIDATE_INT), $submittedIds), static fn($id) => $id !== false && $id > 0)));
            if ($ids === []) throw new RuntimeException('Select at least one valid category.');
            $pdo->beginTransaction();
            try {
                foreach ($ids as $id) {
                    if ($action === 'bulk_delete') {
                        $check = $pdo->prepare('SELECT COUNT(*) FROM knowledge_base WHERE category_id=:id');
                        $check->execute(['id'=>$id]);
                        if ((int)$check->fetchColumn() > 0) throw new RuntimeException('Selected categories must be empty before they can be deleted.');
                        $statement = $pdo->prepare('DELETE FROM categories WHERE id=:id');
                        $statement->execute(['id'=>$id]);
                        if ($statement->rowCount()) admin_log($pdo, $admin['id'], 'delete', 'category', (int)$id);
                    } else {
                        $visible = $action === 'bulk_show_quick_action' ? 1 : 0;
                        $statement = $pdo->prepare('UPDATE categories SET show_in_student_panel=:visible WHERE id=:id');
                        $statement->execute(['visible'=>$visible,'id'=>$id]);
                        if ($statement->rowCount()) admin_log($pdo, $admin['id'], $visible ? 'show_quick_action' : 'hide_quick_action', 'category', (int)$id);
                    }
                }
                $pdo->commit();
            } catch (Throwable $exception) {
                if ($pdo->inTransaction()) $pdo->rollBack();
                throw $exception;
            }
        } elseif ($action === 'delete') {
            $id = filter_var($_POST['id'] ?? null, FILTER_VALIDATE_INT);
            if (!$id) throw new RuntimeException('Invalid category.');
            $check = $pdo->prepare('SELECT COUNT(*) FROM knowledge_base WHERE category_id=:id');
            $check->execute(['id'=>$id]);
            if ((int)$check->fetchColumn() > 0) throw new RuntimeException('This category is in use. Move or delete its knowledge entries first.');
            $pdo->prepare('DELETE FROM categories WHERE id=:id')->execute(['id'=>$id]);
            admin_log($pdo, $admin['id'], 'delete', 'category', (int)$id);
        } else {
            $submittedId = trim((string) ($_POST['id'] ?? ''));
            $id = null;
            if ($submittedId !== '') {
                $id = filter_var($submittedId, FILTER_VALIDATE_INT);
                if ($id === false || $id < 1) throw new RuntimeException('Invalid category.');
            }
            $name = trim((string)($_POST['name'] ?? ''));
            $description = trim((string)($_POST['description'] ?? ''));
            if ($name === '' || strlen($name) > 100) throw new RuntimeException('Enter a category name up to 100 characters.');
            if (strlen($description) > 500) throw new RuntimeException('Category descriptions must be 500 characters or fewer.');
            if ($id) {
                $exists = $pdo->prepare('SELECT COUNT(*) FROM categories WHERE id=:id');
                $exists->execute(['id'=>$id]);
                if (!(int) $exists->fetchColumn()) throw new RuntimeException('Category not found.');
                $statement = $pdo->prepare('UPDATE categories SET name=:name,description=:description WHERE id=:id');
                $statement->execute(['name'=>$name,'description'=>$description?:null,'id'=>$id]);
            } else {
                $statement = $pdo->prepare('INSERT INTO categories (name,description) VALUES (:name,:description)');
                $statement->execute(['name'=>$name,'description'=>$description?:null]);
                $id = (int)$pdo->lastInsertId();
            }
            admin_log($pdo, $admin['id'], 'save', 'category', $id);
        }
        $returnQuery = trim((string) ($_POST['return_q'] ?? ''));
        $returnSort = (string) ($_POST['return_sort'] ?? 'alpha');
        $returnState = $returnQuery !== '' ? ['q' => $returnQuery] : [];
        if (in_array($returnSort, ['alpha', 'entries_desc', 'entries_asc'], true) && $returnSort !== 'alpha') $returnState['sort'] = $returnSort;
        $returnState['saved'] = '1';
        header('Location: categories.php?' . http_build_query($returnState));
        exit;
    } catch (Throwable $exception) {
        error_log('NEW COMSAI category operation failed: ' . $exception->getMessage());
        $error = $exception instanceof RuntimeException ? $exception->getMessage() : 'Category name already exists or the operation failed.';
    }
}

$edit = null;
$editId = filter_var($_GET['edit'] ?? null, FILTER_VALIDATE_INT);
if ($editId) {
    $statement = $pdo->prepare('SELECT * FROM categories WHERE id=:id');
    $statement->execute(['id'=>$editId]);
    $edit = $statement->fetch() ?: null;
}
$q = trim((string)($_GET['q'] ?? ''));
$sort = in_array($_GET['sort'] ?? '', ['alpha', 'entries_desc', 'entries_asc'], true) ? (string) $_GET['sort'] : 'alpha';
$filterParams = array_filter(['q' => $q, 'sort' => $sort === 'alpha' ? '' : $sort], static fn ($value): bool => $value !== '');
$orderBy = match ($sort) {
    'entries_desc' => 'knowledge_count DESC, c.name ASC',
    'entries_asc' => 'knowledge_count ASC, c.name ASC',
    default => 'c.name ASC',
};
$rowsQuery = $pdo->query('SELECT c.*,COUNT(k.id) AS knowledge_count FROM categories c LEFT JOIN knowledge_base k ON k.category_id=c.id GROUP BY c.id ORDER BY ' . $orderBy);
$rows = $rowsQuery->fetchAll();
admin_layout_start('Categories', 'categories.php');
?>
<?php if ($error): ?><div class="alert" role="alert"><?= h($error) ?></div><?php elseif (isset($_GET['saved'])): ?><div class="success" role="status">Changes saved.</div><?php endif; ?>
<section class="form-panel admin-form" id="admin-form">
  <h2><?= $edit ? 'Edit category' : 'Add category' ?></h2>
  <form method="post" data-confirm="Save this category?"><input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><input type="hidden" name="id" value="<?= h($edit['id'] ?? '') ?>"><input type="hidden" name="return_q" value="<?= h($q) ?>"><input type="hidden" name="return_sort" value="<?= h($sort ?? 'alpha') ?>">
    <div class="field"><label for="name">Category name</label><input id="name" name="name" maxlength="100" required value="<?= h($edit['name'] ?? '') ?>"></div>
    <div class="field"><label for="description">Description (optional)</label><input id="description" name="description" maxlength="500" value="<?= h($edit['description'] ?? '') ?>"></div>
    <div class="form-actions"><button class="primary-button">Save category</button><?php if ($edit): ?><a class="secondary-button" id="category-cancel" href="categories.php<?= $filterParams ? '?' . h(http_build_query($filterParams)) : '' ?>" data-confirm="Cancel editing this category? Unsaved changes will be lost.">Cancel</a><?php endif; ?></div>
  </form>
</section>
<section class="admin-section">
  <div class="section-title"><div><h2>Categories</h2><p>Choose which categories appear in the student panel. Categories with knowledge entries cannot be deleted.</p></div></div>
  <form method="get" class="filter-bar" data-category-search><div class="field"><label for="category-q">Search categories</label><div class="admin-search-input"><input id="category-q" name="q" value="<?= h($q) ?>" autocomplete="off" placeholder="Search categories"><span aria-hidden="true"><svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="7"></circle><path d="m16 16 4 4"></path></svg></span><button class="admin-search-clear" type="button" data-search-clear aria-label="Clear search" hidden><svg viewBox="0 0 24 24" aria-hidden="true"><path d="m6 6 12 12M18 6 6 18"></path></svg></button></div></div><div class="field"><label for="category-sort">Sort by</label><select id="category-sort" name="sort"><option value="alpha" <?= $sort === 'alpha' ? 'selected' : '' ?>>Alphabetical</option><option value="entries_desc" <?= $sort === 'entries_desc' ? 'selected' : '' ?>>Most knowledge entries</option><option value="entries_asc" <?= $sort === 'entries_asc' ? 'selected' : '' ?>>Fewest knowledge entries</option></select></div></form>
  <form id="category-bulk-form" method="post" class="knowledge-bulk-toolbar"><input type="hidden" name="_csrf" value="<?= h(csrf_token()) ?>"><input type="hidden" name="return_q" value="<?= h($q) ?>"><input type="hidden" name="return_sort" value="<?= h($sort) ?>"><span id="category-selection-count" aria-live="polite">0 selected</span><button class="secondary-button" type="button" id="category-select-all">Select all</button><label class="sr-only" for="category-bulk-action">Bulk action</label><select id="category-bulk-action" name="action" required><option value="">Choose action</option><option value="bulk_show_quick_action">Show in Student Interface</option><option value="bulk_hide_quick_action">Hide in Student Interface</option><option value="bulk_delete">Delete</option></select><button class="primary-button" type="submit">Apply</button></form>
  <div class="table-wrap"><table>
  <thead><tr><th></th><th>Name</th><th>Description</th><th>Knowledge entries</th><th>Student panel</th><th>Actions</th></tr></thead>
    <tbody>
    <?php foreach ($rows as $row): ?><tr data-category-row data-knowledge-count="<?= (int)$row['knowledge_count'] ?>">
      <td><input type="checkbox" name="ids[]" value="<?= (int)$row['id'] ?>" form="category-bulk-form" aria-label="Select <?= h($row['name']) ?>"></td>
      <td><strong><?= h($row['name']) ?></strong></td><td><?= h($row['description']) ?></td><td><?= (int)$row['knowledge_count'] ?></td><td><?= (int)$row['show_in_student_panel'] === 1 ? 'Shown' : 'Hidden' ?></td>
        <td><a class="secondary-button small-button" href="?<?= h(http_build_query(array_merge($filterParams, ['edit' => (int)$row['id']]))) ?>#admin-form" data-category-edit data-confirm="Edit this category?">Edit</a></td>
      </tr><?php endforeach; ?>
    <tr id="category-no-results" <?= $rows === [] ? '' : 'hidden' ?>><td colspan="6" class="empty-state">No matching categories.</td></tr>
    </tbody>
  </table></div>
</section>
<?php admin_layout_end(); ?>
