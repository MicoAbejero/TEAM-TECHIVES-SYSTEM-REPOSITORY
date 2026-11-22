(() => {
  document.querySelectorAll('.admin-search-input').forEach((wrapper) => {
    const input = wrapper.querySelector('input');
    const clearButton = wrapper.querySelector('[data-search-clear]');
    if (!input || !clearButton) return;
    const updateClearButton = () => { clearButton.hidden = input.value.length === 0; };
    input.addEventListener('input', updateClearButton);
    clearButton.addEventListener('click', () => {
      input.value = '';
      input.dispatchEvent(new Event('input', { bubbles: true }));
      input.focus();
    });
    updateClearButton();
  });

  const syncPanelFilters = (fields, hiddenNames, linkSelector) => {
    const params = new URLSearchParams(location.search);
    fields.forEach(([key, field]) => {
      if (field.value) params.set(key, field.value); else params.delete(key);
    });
    params.delete('saved');
    const query = params.toString();
    history.replaceState({ ...(history.state || {}) }, '', `${location.pathname}${query ? `?${query}` : ''}${location.hash}`);
    Object.entries(hiddenNames).forEach(([key, name]) => {
      document.querySelectorAll(`input[name="${name}"]`).forEach((input) => { input.value = fields.find(([fieldKey]) => fieldKey === key)?.[1].value || ''; });
    });
    document.querySelectorAll(linkSelector).forEach((link) => {
      const href = new URL(link.href, location.href);
      fields.forEach(([key, field]) => {
        if (field.value) href.searchParams.set(key, field.value); else href.searchParams.delete(key);
      });
      link.href = href.pathname + href.search + href.hash;
    });
  };
  const toggle = document.querySelector(".menu-toggle");
  const sidebar = document.querySelector(".admin-sidebar");
  const studentInterfaceMenu = document.querySelector('.student-interface-menu');
  document.addEventListener('click', (event) => {
    if (studentInterfaceMenu?.open && !studentInterfaceMenu.contains(event.target)) studentInterfaceMenu.open = false;
  });
  const panelLinks = [...document.querySelectorAll('.admin-sidebar a.nav-link[href]')];
  const panelStateKey = (url) => `comsai-admin-panel:${url.pathname}`;
  panelLinks.forEach((link) => {
    const target = new URL(link.href, location.href);
    if (target.origin !== location.origin || target.pathname === location.pathname) return;
    try {
      const remembered = sessionStorage.getItem(panelStateKey(target));
      if (remembered) link.href = remembered;
    } catch {}
  });
  document.querySelectorAll('.admin-sidebar a.nav-link[href]').forEach((link) => {
    link.addEventListener('click', (event) => {
      if (event.button !== 0 || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
      const target = new URL(link.href, location.href);
    if (target.origin !== location.origin || target.pathname === location.pathname) return;
      try { sessionStorage.setItem(panelStateKey(location), location.href); } catch {}
    });
  });
  if (toggle && sidebar)
    toggle.addEventListener("click", () => {
      const expanded = toggle.getAttribute("aria-expanded") === "true";
      toggle.setAttribute("aria-expanded", String(!expanded));
      sidebar.classList.toggle("open", !expanded);
    });
    document.querySelectorAll('.toggle-password').forEach((passwordToggle) => {
      passwordToggle.addEventListener('click', () => {
        const input = document.getElementById(passwordToggle.getAttribute('aria-controls')) || document.querySelector('#password');
        if (!input) return;
        const visible = input.type === 'password';
        input.type = visible ? 'text' : 'password';
        passwordToggle.textContent = visible ? 'Hide' : 'Show';
        const fieldName = input.labels?.[0]?.textContent?.trim().toLocaleLowerCase() || 'password';
        passwordToggle.setAttribute('aria-label', `${visible ? 'Hide' : 'Show'} ${fieldName}`);
      });
    });
  document.querySelectorAll('form[data-confirm]').forEach((form) => {
    form.addEventListener('submit', (event) => {
      if (!window.confirm(form.dataset.confirm)) event.preventDefault();
    });
  });
  document.querySelectorAll('form[data-student-interface-form]').forEach((form) => {
    form.addEventListener('submit', async (event) => {
      event.preventDefault();
      const button = event.submitter || form.querySelector('button[type="submit"]');
      const status = document.querySelector('[data-interface-status]');
      const forms = [...document.querySelectorAll('form[data-student-interface-form]')];
      if (!button || !status) return;
      const action = button.value;
      forms.forEach((item) => { item.querySelector('button').disabled = true; });
      status.textContent = 'Updating…';
      try {
        const data = new FormData(form);
        data.set('action', action);
        const response = await fetch(form.getAttribute('action'), { method: 'POST', body: data, headers: { Accept: 'application/json' } });
        const payload = await response.json();
        if (!response.ok || !payload.ok) throw new Error(payload.error || 'Could not update Student Interface.');
        status.textContent = payload.enabled ? 'Enabled' : 'Disabled';
        status.classList.toggle('is-enabled', Boolean(payload.enabled));
        status.classList.toggle('is-disabled', !payload.enabled);
        forms.forEach((item) => {
          const actionButton = item.querySelector('button');
          actionButton.disabled = (actionButton.value === 'enable') === payload.enabled;
        });
      } catch (error) {
        status.textContent = error.message || 'Could not update Student Interface.';
        forms.forEach((item) => { item.querySelector('button').disabled = false; });
      }
    });
  });
  document.querySelectorAll('a[data-confirm]').forEach((link) => {
    link.addEventListener('click', (event) => {
      if (!window.confirm(link.dataset.confirm)) event.preventDefault();
    });
  });

  const draftPagePrefix = `comsai-admin-draft:${location.pathname}:`;
  const adminForms = [...document.querySelectorAll('.admin-form form')];
  const draftForms = adminForms.filter((form) => !form.querySelector('input[type="password"]'));
  const formDraftKeys = new Map();
  const draftableFields = (form) => [...form.querySelectorAll('input, textarea, select')].filter((field) =>
    field.name &&
    field.type !== 'hidden' &&
    field.type !== 'password' &&
    field.type !== 'file' &&
    !/csrf|password|email_code|token/i.test(field.name)
  );
  const clearPageDrafts = () => {
    try {
      Object.keys(sessionStorage).filter((key) => key.startsWith(draftPagePrefix)).forEach((key) => sessionStorage.removeItem(key));
    } catch {}
  };

  if (new URLSearchParams(location.search).has('saved')) {
    clearPageDrafts();
  } else {
    draftForms.forEach((form) => {
      const editId = new URLSearchParams(location.search).get('edit') || 'new';
      const formIndex = adminForms.indexOf(form);
      const key = `${draftPagePrefix}${editId}:${formIndex}`;
      formDraftKeys.set(form, key);
      try {
        const saved = JSON.parse(sessionStorage.getItem(key) || '{}');
        draftableFields(form).forEach((field) => {
          if (Object.hasOwn(saved, field.name)) field.value = saved[field.name];
        });
      } catch {}

      const saveDraft = () => {
        const saved = {};
        draftableFields(form).forEach((field) => { saved[field.name] = field.value; });
        try { sessionStorage.setItem(key, JSON.stringify(saved)); } catch {}
      };
      form.addEventListener('input', saveDraft);
      form.addEventListener('change', saveDraft);
    });
  }

  document.querySelectorAll('a[data-confirm]').forEach((link) => {
    if (!link.textContent.trim().toLocaleLowerCase().startsWith('cancel')) return;
    link.addEventListener('click', (event) => {
      if (event.defaultPrevented) return;
      const form = link.closest('.admin-form')?.querySelector('form');
      const key = form && formDraftKeys.get(form);
      if (key) {
        try { sessionStorage.removeItem(key); } catch {}
      }
    });
  });

  const publicationSelect = document.querySelector('#status[name="status"]');
  const knowledgeSaveButton = document.querySelector('#knowledge-save-button');
  if (publicationSelect && knowledgeSaveButton) {
    const updateKnowledgeSaveLabel = () => {
      knowledgeSaveButton.textContent = publicationSelect.value === 'published' ? 'Publish' : 'Save draft';
    };
    publicationSelect.addEventListener('change', updateKnowledgeSaveLabel);
    updateKnowledgeSaveLabel();
  }
  const announcementSaveButton = document.querySelector('#announcement-save-button');
  if (publicationSelect && announcementSaveButton) {
    const updateAnnouncementSaveLabel = () => {
      announcementSaveButton.textContent = publicationSelect.value === 'published' ? 'Publish' : 'Save draft';
    };
    publicationSelect.addEventListener('change', updateAnnouncementSaveLabel);
    updateAnnouncementSaveLabel();
  }

  const searchForm = document.querySelector('[data-knowledge-search]');
  const searchInput = searchForm?.querySelector('#q');
  const statusFilter = searchForm?.querySelector('#filter-status');
  const categoryFilter = searchForm?.querySelector('#filter-category');
  const knowledgeSort = searchForm?.querySelector('#filter-sort');
  const entryRows = [...document.querySelectorAll('[data-knowledge-row]')];
  const noResults = document.querySelector('#knowledge-no-results');
  if (searchForm && searchInput && statusFilter && categoryFilter && noResults) {
    const syncKnowledgeState = () => {
      const params = new URLSearchParams(location.search);
      [['q', searchInput.value], ['status', statusFilter.value], ['category_id', categoryFilter.value], ['sort', knowledgeSort?.value || 'latest']].forEach(([key, value]) => {
        if (value) params.set(key, value); else params.delete(key);
      });
      params.delete('saved');
      const query = params.toString();
      history.replaceState({ ...(history.state || {}) }, '', `${location.pathname}${query ? `?${query}` : ''}${location.hash}`);
      document.querySelectorAll('input[name="return_q"]').forEach((field) => { field.value = searchInput.value; });
      document.querySelectorAll('input[name="return_status"]').forEach((field) => { field.value = statusFilter.value; });
      document.querySelectorAll('input[name="return_category_id"]').forEach((field) => { field.value = categoryFilter.value; });
      document.querySelectorAll('input[name="return_sort"]').forEach((field) => { field.value = knowledgeSort?.value || 'latest'; });
      document.querySelectorAll('[data-knowledge-edit], #knowledge-cancel').forEach((link) => {
        const href = new URL(link.href, location.href);
        ['q', 'status', 'category_id', 'sort'].forEach((key) => {
          const value = params.get(key);
          if (value) href.searchParams.set(key, value); else href.searchParams.delete(key);
        });
        link.href = href.pathname + href.search + href.hash;
      });
    };
    const filterEntries = () => {
      const sort = knowledgeSort?.value || 'latest';
      const tbody = document.querySelector('#knowledge-entries');
      entryRows.sort((a, b) => {
        if (sort === 'title') {
          const titleA = a.querySelector('strong')?.textContent.trim() || '';
          const titleB = b.querySelector('strong')?.textContent.trim() || '';
          return titleA.localeCompare(titleB);
        }
        const dateCell = (row) => row.dataset.sortDate || row.cells[row.querySelector('input[name="ids[]"]') ? 4 : 3]?.textContent.split('/')[0].trim() || '';
        const da = Date.parse(dateCell(a)) || 0, db = Date.parse(dateCell(b)) || 0;
        return sort === 'oldest' ? da - db : db - da;
      }).forEach((row) => tbody?.appendChild(row));
      const query = searchInput.value.trim().toLocaleLowerCase();
      const status = statusFilter.value.toLocaleLowerCase();
      const category = categoryFilter.value;
      let visibleCount = 0;
      entryRows.forEach((row) => {
        const matchesText = row.textContent.toLocaleLowerCase().includes(query);
        const statusCellIndex = row.querySelector('input[name="ids[]"]') ? 3 : 2;
        const matchesStatus = !status || row.cells[statusCellIndex]?.textContent.trim().toLocaleLowerCase() === status;
        const matchesCategory = !category || row.dataset.categoryId === category;
        row.hidden = !(matchesText && matchesStatus && matchesCategory);
        if (!row.hidden) visibleCount += 1;
      });
      noResults.hidden = visibleCount > 0;
    };
    searchInput.addEventListener('input', () => { filterEntries(); syncKnowledgeState(); });
    statusFilter.addEventListener('change', () => { filterEntries(); syncKnowledgeState(); });
    categoryFilter.addEventListener('change', () => { filterEntries(); syncKnowledgeState(); });
    knowledgeSort?.addEventListener('change', () => { filterEntries(); syncKnowledgeState(); });
    filterEntries();
    syncKnowledgeState();
  }

  const bulkForm = document.querySelector('#knowledge-bulk-form');
  const selectionBoxes = [...document.querySelectorAll('input[name="ids[]"]')];
  const selectAllButton = document.querySelector('#knowledge-select-all');
  const selectionCount = document.querySelector('#knowledge-selection-count');
  const updateSelectionControls = () => {
    const selectedCount = selectionBoxes.filter((box) => box.checked).length;
    const visibleBoxes = selectionBoxes.filter((box) => !box.closest('tr').hidden);
    const allVisibleSelected = visibleBoxes.length > 0 && visibleBoxes.every((box) => box.checked);
    if (selectionCount) selectionCount.textContent = `${selectedCount} selected`;
    if (selectAllButton) {
      selectAllButton.textContent = allVisibleSelected
        ? 'Unselect all'
        : 'Select all';
    }
  };
  selectionBoxes.forEach((box) => box.addEventListener('change', updateSelectionControls));
  searchInput?.addEventListener('input', updateSelectionControls);
  statusFilter?.addEventListener('change', updateSelectionControls);
  categoryFilter?.addEventListener('change', updateSelectionControls);
  selectAllButton?.addEventListener('click', () => {
    const visibleBoxes = selectionBoxes.filter((box) => !box.closest('tr').hidden);
    const selectAll = visibleBoxes.some((box) => !box.checked);
    visibleBoxes.forEach((box) => {
      box.checked = selectAll;
    });
    updateSelectionControls();
  });
  updateSelectionControls();
  bulkForm?.addEventListener('submit', (event) => {
    const selectedCount = selectionBoxes.filter((box) => box.checked).length;
    if (!selectedCount) {
      event.preventDefault();
      window.alert('Select at least one entry.');
      return;
    }
    const action = bulkForm.querySelector('#knowledge-bulk-action')?.value;
    const actionMessages = {
      bulk_publish: 'Publish the selected information? Students will be able to see it in COMSAI.',
      bulk_unpublish: 'Unpublish the selected information? Students will no longer see it in COMSAI.',
      bulk_delete: 'Delete the selected information? This cannot be undone.',
    };
    const actionText = actionMessages[action];
    if (!actionText) {
      event.preventDefault();
      window.alert('Choose a bulk action.');
    } else if (!window.confirm(`${actionText} (${selectedCount} selected)`)) {
      event.preventDefault();
    }
  });

  const announcementSearch = document.querySelector('[data-announcement-search]');
  const announcementSearchInput = announcementSearch?.querySelector('#q');
  const announcementStatusFilter = announcementSearch?.querySelector('#filter-status');
  const announcementSort = announcementSearch?.querySelector('#filter-sort');
  const announcementRows = [...document.querySelectorAll('[data-announcement-row]')];
  const announcementNoResults = document.querySelector('#announcement-no-results');
  const filterAnnouncements = () => {
    if (!announcementSearchInput || !announcementStatusFilter || !announcementNoResults) return;
    const query = announcementSearchInput.value.trim().toLocaleLowerCase();
    const status = announcementStatusFilter.value.toLocaleLowerCase();
    const sort = announcementSort?.value || 'latest';
    const tbody = announcementRows[0]?.parentElement;
    announcementRows.sort((a, b) => {
      if (sort === 'title') {
        const titleA = a.querySelector('strong')?.textContent.trim() || '';
        const titleB = b.querySelector('strong')?.textContent.trim() || '';
        return titleA.localeCompare(titleB);
      }
      const dateCell = (row) => row.dataset.sortDate || row.cells[row.querySelector('input[name="ids[]"]') ? 3 : 2]?.textContent.split('/')[0].trim() || '';
      const da = Date.parse(dateCell(a)) || 0, db = Date.parse(dateCell(b)) || 0;
      return sort === 'oldest' ? da - db : db - da;
    }).forEach((row) => tbody?.appendChild(row));
    let visibleCount = 0;
    announcementRows.forEach((row) => {
      const matchesText = row.textContent.toLocaleLowerCase().includes(query);
      const matchesStatus = !status || row.querySelector('.status')?.textContent.trim().toLocaleLowerCase() === status;
      row.hidden = !(matchesText && matchesStatus);
      if (!row.hidden) visibleCount += 1;
    });
    announcementNoResults.hidden = visibleCount > 0;
  };
  announcementSearchInput?.addEventListener('input', filterAnnouncements);
  announcementStatusFilter?.addEventListener('change', filterAnnouncements);
  announcementSort?.addEventListener('change', filterAnnouncements);
  filterAnnouncements();
  if (announcementSearchInput && announcementStatusFilter) {
    const syncAnnouncementFilters = () => syncPanelFilters(
      [['q', announcementSearchInput], ['status', announcementStatusFilter], ['sort', announcementSort]],
      { q: 'return_q', status: 'return_status', sort: 'return_sort' },
      '[data-announcement-edit], #announcement-cancel'
    );
    announcementSearchInput.addEventListener('input', syncAnnouncementFilters);
    announcementStatusFilter.addEventListener('change', syncAnnouncementFilters);
    announcementSort?.addEventListener('change', syncAnnouncementFilters);
    syncAnnouncementFilters();
  }

  const announcementBulkForm = document.querySelector('#announcement-bulk-form');
  const announcementBoxes = [...document.querySelectorAll('#announcement-bulk-form ~ .table-wrap input[name="ids[]"], input[name="ids[]"][form="announcement-bulk-form"]')];
  const announcementSelectAll = document.querySelector('#announcement-select-all');
  const announcementSelectionCount = document.querySelector('#announcement-selection-count');
  const updateAnnouncementSelection = () => {
    const selectedCount = announcementBoxes.filter((box) => box.checked).length;
    const visibleBoxes = announcementBoxes.filter((box) => !box.closest('tr')?.hidden);
    const allVisibleSelected = visibleBoxes.length > 0 && visibleBoxes.every((box) => box.checked);
    if (announcementSelectionCount) announcementSelectionCount.textContent = `${selectedCount} selected`;
    if (announcementSelectAll) announcementSelectAll.textContent = allVisibleSelected ? 'Unselect all' : 'Select all';
  };
  announcementBoxes.forEach((box) => box.addEventListener('change', updateAnnouncementSelection));
  announcementSearchInput?.addEventListener('input', updateAnnouncementSelection);
  announcementStatusFilter?.addEventListener('change', updateAnnouncementSelection);
  announcementSelectAll?.addEventListener('click', () => {
    const visibleBoxes = announcementBoxes.filter((box) => !box.closest('tr')?.hidden);
    const selectAll = visibleBoxes.some((box) => !box.checked);
    visibleBoxes.forEach((box) => { box.checked = selectAll; });
    updateAnnouncementSelection();
  });
  updateAnnouncementSelection();
  announcementBulkForm?.addEventListener('submit', (event) => {
    const selectedCount = announcementBoxes.filter((box) => box.checked).length;
    if (!selectedCount) {
      event.preventDefault();
      window.alert('Select at least one announcement.');
      return;
    }
    const action = announcementBulkForm.querySelector('#announcement-bulk-action')?.value;
    const actionMessages = {
      bulk_publish: 'Publish the selected announcements? Students will be able to see them in COMSAI.',
      bulk_unpublish: 'Unpublish the selected announcements? Students will no longer see them in COMSAI.',
      bulk_delete: 'Delete the selected announcements? This cannot be undone.',
    };
    const actionText = actionMessages[action];
    if (!actionText) {
      event.preventDefault();
      window.alert('Choose a bulk action.');
    } else if (!window.confirm(`${actionText} (${selectedCount} selected)`)) {
      event.preventDefault();
    }
  });

  const categorySearch = document.querySelector('[data-category-search]');
  const categorySearchInput = categorySearch?.querySelector('#category-q');
  const categorySort = categorySearch?.querySelector('#category-sort');
  const categoryRows = [...document.querySelectorAll('[data-category-row]')];
  const categoryNoResults = document.querySelector('#category-no-results');
  const filterCategories = () => {
    if (!categorySearchInput || !categoryNoResults) return;
    const query = categorySearchInput.value.trim().toLocaleLowerCase();
    const sort = categorySort?.value || 'alpha';
    const tbody = categoryRows[0]?.parentElement;
    categoryRows.sort((a, b) => {
      const nameA = a.cells[1]?.textContent.trim() || '';
      const nameB = b.cells[1]?.textContent.trim() || '';
      const countIndex = a.querySelector('input[name="ids[]"]') ? 3 : 2;
      const countA = Number(a.cells[countIndex]?.textContent.trim()) || 0;
      const countB = Number(b.cells[countIndex]?.textContent.trim()) || 0;
      if (sort === 'entries_desc') return countB - countA || nameA.localeCompare(nameB);
      if (sort === 'entries_asc') return countA - countB || nameA.localeCompare(nameB);
      return nameA.localeCompare(nameB);
    }).forEach((row) => tbody?.appendChild(row));
    let visibleCount = 0;
    categoryRows.forEach((row) => {
      row.hidden = !row.textContent.toLocaleLowerCase().includes(query);
      if (!row.hidden) visibleCount += 1;
    });
    categoryNoResults.hidden = visibleCount > 0;
  };
  categorySearchInput?.addEventListener('input', filterCategories);
  categorySort?.addEventListener('change', filterCategories);
  filterCategories();
  if (categorySearchInput) {
    const syncCategoryFilters = () => syncPanelFilters(
      [['q', categorySearchInput], ['sort', categorySort]],
      { q: 'return_q', sort: 'return_sort' },
      '[data-category-edit], #category-cancel'
    );
    categorySearchInput.addEventListener('input', syncCategoryFilters);
    categorySort?.addEventListener('change', syncCategoryFilters);
    syncCategoryFilters();
  }

  const categoryBulkForm = document.querySelector('#category-bulk-form');
  const categoryBoxes = [...document.querySelectorAll('input[name="ids[]"][form="category-bulk-form"]')];
  const categorySelectAll = document.querySelector('#category-select-all');
  const categorySelectionCount = document.querySelector('#category-selection-count');
  const categoryBulkAction = document.querySelector('#category-bulk-action');
  const updateCategorySelection = () => {
    const selectedCount = categoryBoxes.filter((box) => box.checked).length;
    const visibleBoxes = categoryBoxes.filter((box) => !box.disabled && !box.closest('tr')?.hidden);
    const allVisibleSelected = visibleBoxes.length > 0 && visibleBoxes.every((box) => box.checked);
    if (categorySelectionCount) categorySelectionCount.textContent = `${selectedCount} selected`;
    if (categorySelectAll) categorySelectAll.textContent = allVisibleSelected ? 'Unselect all' : 'Select all';
  };
  categoryBoxes.forEach((box) => box.addEventListener('change', updateCategorySelection));
  categorySearchInput?.addEventListener('input', updateCategorySelection);
  categorySelectAll?.addEventListener('click', () => {
    const visibleBoxes = categoryBoxes.filter((box) => !box.disabled && !box.closest('tr')?.hidden);
    const selectAll = visibleBoxes.some((box) => !box.checked);
    visibleBoxes.forEach((box) => { box.checked = selectAll; });
    updateCategorySelection();
  });
  updateCategorySelection();
  categoryBulkForm?.addEventListener('submit', (event) => {
    const selectedCount = categoryBoxes.filter((box) => box.checked).length;
    if (!selectedCount) {
      event.preventDefault();
      window.alert('Select at least one category.');
      return;
    }
    const action = categoryBulkAction?.value;
    const actionMessages = {
      bulk_show_quick_action: 'Show the selected categories in the student panel?',
      bulk_hide_quick_action: 'Hide the selected categories from the student panel?',
      bulk_delete: 'Delete the selected empty categories? This cannot be undone.',
    };
    const actionText = actionMessages[action];
    if (!actionText) {
      event.preventDefault();
      window.alert('Choose a bulk action.');
    } else if (action === 'bulk_delete' && categoryBoxes.some((box) => box.checked && Number(box.closest('tr')?.dataset.knowledgeCount) > 0)) {
      event.preventDefault();
      window.alert('Only empty categories can be deleted. Deselect categories that have knowledge entries.');
    } else if (!window.confirm(`${actionText} (${selectedCount} selected)`)) {
      event.preventDefault();
    }
  });

  const feedbackSearch = document.querySelector('[data-feedback-search]');
  const feedbackSearchInput = feedbackSearch?.querySelector('#feedback-q');
  const feedbackSort = feedbackSearch?.querySelector('#feedback-sort');
  const feedbackRows = [...document.querySelectorAll('[data-feedback-row]')];
  const feedbackNoResults = document.querySelector('#feedback-no-results');
  const feedbackBulkForm = document.querySelector('#feedback-bulk-form');
  const feedbackBoxes = [...document.querySelectorAll('input[name="ids[]"][form="feedback-bulk-form"]')];
  const feedbackSelectAll = document.querySelector('#feedback-select-all');
  const feedbackSelectionCount = document.querySelector('#feedback-selection-count');
  const feedbackDeleteButton = document.querySelector('#feedback-delete-button');
  const filterFeedback = () => {
    if (!feedbackSearchInput || !feedbackNoResults) return;
    const sort = feedbackSort?.value || 'latest';
    const query = feedbackSearchInput.value.trim().toLocaleLowerCase();
    const tbody = feedbackRows[0]?.parentElement;
    feedbackRows.sort((a, b) => {
      if (sort === 'title') return (a.cells[1]?.textContent.trim() || '').localeCompare(b.cells[1]?.textContent.trim() || '');
      const da = Date.parse(a.dataset.sortDate || '') || 0;
      const db = Date.parse(b.dataset.sortDate || '') || 0;
      return sort === 'oldest' ? da - db : db - da;
    }).forEach((row) => tbody?.appendChild(row));
    let visibleCount = 0;
    feedbackRows.forEach((row) => {
      row.hidden = !row.cells[1]?.textContent.toLocaleLowerCase().includes(query);
      if (!row.hidden) visibleCount += 1;
    });
    feedbackNoResults.hidden = visibleCount > 0;
  };
  feedbackSearchInput?.addEventListener('input', filterFeedback);
  feedbackSort?.addEventListener('change', filterFeedback);
  filterFeedback();
  if (feedbackSearchInput) {
    const syncFeedbackFilters = () => syncPanelFilters(
      [['q', feedbackSearchInput], ['sort', feedbackSort]],
      { q: 'return_q', sort: 'return_sort' },
      '.no-feedback-edit-links'
    );
    feedbackSearchInput.addEventListener('input', syncFeedbackFilters);
    feedbackSort?.addEventListener('change', syncFeedbackFilters);
    syncFeedbackFilters();
  }
  const updateFeedbackSelection = () => {
    const selectedCount = feedbackBoxes.filter((box) => box.checked).length;
    const visibleBoxes = feedbackBoxes.filter((box) => !box.closest('tr')?.hidden);
    const allVisibleSelected = visibleBoxes.length > 0 && visibleBoxes.every((box) => box.checked);
    if (feedbackSelectionCount) feedbackSelectionCount.textContent = `${selectedCount} selected`;
    if (feedbackSelectAll) feedbackSelectAll.textContent = allVisibleSelected ? 'Unselect all' : 'Select all';
    if (feedbackDeleteButton) feedbackDeleteButton.disabled = selectedCount === 0;
  };
  feedbackBoxes.forEach((box) => box.addEventListener('change', updateFeedbackSelection));
  feedbackSearchInput?.addEventListener('input', updateFeedbackSelection);
  feedbackSelectAll?.addEventListener('click', () => {
    const visibleBoxes = feedbackBoxes.filter((box) => !box.closest('tr')?.hidden);
    const selectAll = visibleBoxes.some((box) => !box.checked);
    visibleBoxes.forEach((box) => { box.checked = selectAll; });
    updateFeedbackSelection();
  });
  updateFeedbackSelection();
  feedbackBulkForm?.addEventListener('submit', (event) => {
    const selectedCount = feedbackBoxes.filter((box) => box.checked).length;
    if (!selectedCount) {
      event.preventDefault();
      window.alert('Select at least one feedback entry.');
      return;
    }
    if (!window.confirm(`Delete the selected student feedback? This cannot be undone. (${selectedCount} selected)`)) event.preventDefault();
  });

  const activitySearch = document.querySelector('[data-activity-search]');
  const activitySearchInput = activitySearch?.querySelector('#activity-q');
  const activitySort = activitySearch?.querySelector('#activity-sort');
  const activityRows = [...document.querySelectorAll('[data-activity-row]')];
  const activityNoResults = document.querySelector('#activity-no-results');
  const activityBulkForm = document.querySelector('#activity-bulk-form');
  const activityBoxes = [...document.querySelectorAll('input[name="ids[]"][form="activity-bulk-form"]')];
  const activitySelectAll = document.querySelector('#activity-select-all');
  const activitySelectionCount = document.querySelector('#activity-selection-count');
  const activityDeleteButton = document.querySelector('#activity-delete-button');
  const filterActivity = () => {
    if (!activitySearchInput || !activityNoResults) return;
    const sort = activitySort?.value || 'latest';
    const query = activitySearchInput.value.trim().toLocaleLowerCase();
    const tbody = activityRows[0]?.parentElement;
    activityRows.sort((a, b) => {
      if (sort === 'title') return (a.cells[1]?.textContent.trim() || '').localeCompare(b.cells[1]?.textContent.trim() || '');
      const da = Date.parse(a.dataset.sortDate || '') || 0;
      const db = Date.parse(b.dataset.sortDate || '') || 0;
      return sort === 'oldest' ? da - db : db - da;
    }).forEach((row) => tbody?.appendChild(row));
    let visibleCount = 0;
    activityRows.forEach((row) => {
      row.hidden = !row.cells[1]?.textContent.toLocaleLowerCase().includes(query);
      if (!row.hidden) visibleCount += 1;
    });
    activityNoResults.hidden = visibleCount > 0;
  };
  activitySearchInput?.addEventListener('input', filterActivity);
  activitySort?.addEventListener('change', filterActivity);
  filterActivity();
  if (activitySearchInput) {
    const syncActivityFilters = () => syncPanelFilters(
      [['q', activitySearchInput], ['sort', activitySort]],
      { q: 'return_q', sort: 'return_sort' },
      '.no-activity-edit-links'
    );
    activitySearchInput.addEventListener('input', syncActivityFilters);
    activitySort?.addEventListener('change', syncActivityFilters);
    syncActivityFilters();
  }
  const updateActivitySelection = () => {
    const selectedCount = activityBoxes.filter((box) => box.checked).length;
    const visibleBoxes = activityBoxes.filter((box) => !box.closest('tr')?.hidden);
    const allVisibleSelected = visibleBoxes.length > 0 && visibleBoxes.every((box) => box.checked);
    if (activitySelectionCount) activitySelectionCount.textContent = `${selectedCount} selected`;
    if (activitySelectAll) activitySelectAll.textContent = allVisibleSelected ? 'Unselect all' : 'Select all';
    if (activityDeleteButton) activityDeleteButton.disabled = selectedCount === 0;
  };
  activityBoxes.forEach((box) => box.addEventListener('change', updateActivitySelection));
  activitySearchInput?.addEventListener('input', updateActivitySelection);
  activitySelectAll?.addEventListener('click', () => {
    const visibleBoxes = activityBoxes.filter((box) => !box.closest('tr')?.hidden);
    const selectAll = visibleBoxes.some((box) => !box.checked);
    visibleBoxes.forEach((box) => { box.checked = selectAll; });
    updateActivitySelection();
  });
  updateActivitySelection();
  activityBulkForm?.addEventListener('submit', (event) => {
    const selectedCount = activityBoxes.filter((box) => box.checked).length;
    if (!selectedCount) {
      event.preventDefault();
      window.alert('Select at least one student question.');
      return;
    }
    if (!window.confirm(`Delete the selected student questions? This cannot be undone. (${selectedCount} selected)`)) event.preventDefault();
  });

  const softNavigate = async (url, options = {}) => {
    const requestId = (window.__comsaiAdminNavigationRequest || 0) + 1;
    window.__comsaiAdminNavigationRequest = requestId;
    const targetUrl = new URL(url, location.href);
    if (targetUrl.origin !== location.origin) return false;
    const currentContent = document.querySelector('.admin-content');
    const currentSidebar = document.querySelector('.admin-sidebar');
    const currentMenu = document.querySelector('.student-interface-menu');
    const keepView = options.viewState || {
      contentScroll: currentContent?.scrollTop || 0,
      windowScroll: window.scrollY,
      sidebarScroll: currentSidebar?.scrollTop || 0,
      sidebarOpen: currentSidebar?.classList.contains('open') || false,
      studentMenuOpen: currentMenu?.open || false,
    };
    const headers = { 'X-Requested-With': 'XMLHttpRequest' };
    const request = { method: options.method || 'GET', credentials: 'same-origin', headers };
    if (options.body) request.body = options.body;
    try {
      const response = await fetch(targetUrl.href, request);
      if (requestId !== window.__comsaiAdminNavigationRequest) return true;
      if (!response.ok) throw new Error('The page could not be updated.');
      const finalUrl = new URL(response.url, targetUrl.href);
      finalUrl.hash = targetUrl.hash;
      const html = await response.text();
      if (requestId !== window.__comsaiAdminNavigationRequest) return true;
      const nextDocument = new DOMParser().parseFromString(html, 'text/html');
      if (!nextDocument.body.classList.contains('admin-page') || finalUrl.origin !== location.origin) {
        location.assign(finalUrl.href);
        return true;
      }

      if (options.history === 'push') {
        history.replaceState({ ...(history.state || {}), viewState: keepView }, '', location.href);
        history.pushState({ viewState: keepView }, '', finalUrl.href);
      } else if (options.history !== 'pop') {
        history.replaceState({ ...(history.state || {}), viewState: keepView }, '', finalUrl.href);
      }
      document.title = nextDocument.title;
      const scriptSources = [...nextDocument.querySelectorAll('script[src]')].map((script) => script.getAttribute('src'));
      const nextBody = document.importNode(nextDocument.body, true);
      nextBody.querySelectorAll('script').forEach((script) => script.remove());
      document.body.replaceWith(nextBody);

      const restoreView = () => {
        const content = document.querySelector('.admin-content');
        const sidebar = document.querySelector('.admin-sidebar');
        const menu = document.querySelector('.student-interface-menu');
        if (content) content.scrollTop = keepView.contentScroll;
        if (sidebar) {
          sidebar.scrollTop = keepView.sidebarScroll;
          sidebar.classList.toggle('open', keepView.sidebarOpen);
        }
        if (menu) menu.open = keepView.studentMenuOpen;
        window.scrollTo(0, keepView.windowScroll);
        if (finalUrl.hash) {
          const target = document.getElementById(decodeURIComponent(finalUrl.hash.slice(1)));
          target?.scrollIntoView({ block: 'start' });
        }
      };
      if (scriptSources.length) {
        let remaining = scriptSources.length;
        scriptSources.forEach((source) => {
          const script = document.createElement('script');
          script.src = new URL(source, finalUrl).href;
          script.onload = () => { remaining -= 1; if (!remaining) restoreView(); };
          script.onerror = () => { remaining -= 1; if (!remaining) restoreView(); };
          document.body.appendChild(script);
        });
      } else {
        restoreView();
      }
      return true;
    } catch (error) {
      if (requestId !== window.__comsaiAdminNavigationRequest) return false;
      if (options.submitter?.isConnected) options.submitter.disabled = false;
      const alert = document.querySelector('.admin-content .alert');
      if (alert) {
        alert.textContent = error.message || 'Could not update this panel. Your current screen is unchanged.';
        alert.hidden = false;
      } else {
        window.alert(error.message || 'Could not update this panel. Your current screen is unchanged.');
      }
      return false;
    }
  };

  document.querySelectorAll('.admin-sidebar a.nav-link[href], [data-knowledge-edit], [data-announcement-edit], [data-category-edit], #knowledge-cancel, #announcement-cancel, #category-cancel, .welcome-admin a[href], .quick-actions a[href]').forEach((link) => {
    link.addEventListener('click', (event) => {
      if (event.defaultPrevented || event.button !== 0 || event.ctrlKey || event.metaKey || event.shiftKey || event.altKey || link.target || link.hasAttribute('download')) return;
      const url = new URL(link.href, location.href);
      if (url.origin !== location.origin || !url.pathname.includes('/admin/')) return;
      event.preventDefault();
      const refreshFeedback = link.hasAttribute('data-feedback-nav') && !link.querySelector('[data-feedback-notification]')?.hidden;
      const refreshActivity = link.hasAttribute('data-activity-nav') && !link.querySelector('[data-activity-notification]')?.hidden;
      if (url.href !== location.href || refreshFeedback || refreshActivity) softNavigate(url.href, { history: url.href === location.href ? 'replace' : 'push' });
    });
  });

  document.querySelectorAll('form').forEach((form) => {
    form.addEventListener('submit', (event) => {
      if (event.defaultPrevented || form.matches('[data-student-interface-form], .logout-form') || form.target || form.enctype === 'multipart/form-data') return;
      const url = new URL(form.getAttribute('action') || location.href, location.href);
      if (url.origin !== location.origin || !url.pathname.includes('/admin/')) return;
      event.preventDefault();
      const method = (form.method || 'get').toUpperCase();
      const data = new FormData(form);
      if (method === 'GET') {
        url.search = '';
        data.forEach((value, key) => url.searchParams.append(key, String(value)));
        softNavigate(url.href, { method: 'GET', history: 'replace' });
      } else {
        if (event.submitter) event.submitter.disabled = true;
        softNavigate(url.href, { method, body: data, history: 'replace', submitter: event.submitter });
      }
    });
  });

  if (!window.__comsaiAdminSoftNavigationBound) {
    window.__comsaiAdminSoftNavigationBound = true;
    window.addEventListener('popstate', (event) => {
      softNavigate(location.href, { history: 'pop', viewState: event.state?.viewState || null });
    });
  }

  const feedbackNotification = document.querySelector('[data-feedback-notification]');
  if (feedbackNotification) {
    if (window.__comsaiFeedbackNotificationTimer) clearInterval(window.__comsaiFeedbackNotificationTimer);
    const refreshFeedbackNotification = async () => {
      try {
        const response = await fetch('../api/admin_feedback_status.php', { credentials: 'same-origin', cache: 'no-store' });
        const payload = response.ok ? await response.json() : null;
        if (payload?.ok) feedbackNotification.hidden = payload.unread < 1;
      } catch {}
    };
    refreshFeedbackNotification();
    window.__comsaiFeedbackNotificationTimer = setInterval(refreshFeedbackNotification, 30000);
  }

  if (window.__comsaiActivityNotificationTimer) {
    clearInterval(window.__comsaiActivityNotificationTimer);
    window.__comsaiActivityNotificationTimer = null;
  }
  const activityNotification = document.querySelector('[data-activity-notification]');
  if (activityNotification) {
    const refreshActivityNotification = async () => {
      try {
        const response = await fetch('../api/admin_activity_status.php', { credentials: 'same-origin', cache: 'no-store' });
        const payload = response.ok ? await response.json() : null;
        if (payload?.ok) activityNotification.hidden = payload.unread < 1;
      } catch {}
    };
    refreshActivityNotification();
    window.__comsaiActivityNotificationTimer = setInterval(refreshActivityNotification, 30000);
  }
const presence = document.querySelector('[data-admin-presence]');
  if (presence) {
    const toggle = presence.querySelector('[data-admin-presence-toggle]');
    const panel = presence.querySelector('[data-admin-presence-panel]');
    const count = presence.querySelector('[data-admin-presence-count]');
    const list = presence.querySelector('[data-admin-presence-list]');
    const csrf = presence.dataset.csrf || '';
    const renderPresence = (admins) => {
      if (count) count.textContent = String(admins.length);
      if (list) {
        list.innerHTML = admins.length
          ? admins.map((item) => `<li>${String(item.name).replace(/[&<>"']/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#039;' }[char]))}</li>`).join('')
          : '<li>No other administrators active</li>';
      }
    };
    const refreshPresence = async () => {
      try {
        const response = await fetch('presence.php', {
          method: 'POST',
          credentials: 'same-origin',
          cache: 'no-store',
          headers: { 'Content-Type': 'application/x-www-form-urlencoded', Accept: 'application/json' },
          body: new URLSearchParams({ _csrf: csrf }),
        });
        const payload = response.ok ? await response.json() : null;
        if (payload?.ok) renderPresence(payload.admins || []);
      } catch {}
    };
    toggle?.addEventListener('click', () => {
      const open = toggle.getAttribute('aria-expanded') === 'true';
      toggle.setAttribute('aria-expanded', String(!open));
      if (panel) panel.hidden = open;
    });
    document.addEventListener('click', (event) => {
      if (!presence.contains(event.target)) {
        toggle?.setAttribute('aria-expanded', 'false');
        if (panel) panel.hidden = true;
      }
    });
    refreshPresence();
    window.__comsaiPresenceTimer = setInterval(refreshPresence, 60000);
  }
})();
