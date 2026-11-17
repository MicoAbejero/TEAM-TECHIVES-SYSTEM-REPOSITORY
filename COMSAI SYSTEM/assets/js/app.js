(() => {
  const form = document.querySelector("#chat-form");
  const input = document.querySelector("#question");
  const list = document.querySelector("#conversation");
  const welcome = document.querySelector("#welcome");
  const sendButton = document.querySelector("#send-button");
  const count = document.querySelector("#char-count");
  const csrf = document.querySelector('meta[name="csrf-token"]').content;
  let busy = false;
  let maintenanceMode = false;
  let historyReady = Promise.resolve();
  const latestAnnouncementButton = document.querySelector('[data-latest-announcement]');
  const latestAnnouncementDot = latestAnnouncementButton?.querySelector('.announcement-notification-dot');
  const announcementSeenStorageKey = 'comsai:latest-announcement-seen';
  const hideLatestAnnouncementDot = () => {
    latestAnnouncementDot?.remove();
    latestAnnouncementButton?.setAttribute('aria-label', 'Latest CCS announcement');
  };
  if (latestAnnouncementButton && latestAnnouncementDot) {
    const announcementKey = latestAnnouncementButton.dataset.latestAnnouncement;
    try {
      if (sessionStorage.getItem(announcementSeenStorageKey) === announcementKey) {
        hideLatestAnnouncementDot();
      }
    } catch {}
    latestAnnouncementButton.addEventListener('click', () => {
      if (busy) return;
      try {
        sessionStorage.setItem(announcementSeenStorageKey, announcementKey);
      } catch {}
      hideLatestAnnouncementDot();
    });
  }

  const scrollToBottom = () => {
    list.scrollTop = list.scrollHeight;
  };
  const appendLinkedText = (parent, text) => {
    const expression = /\*\*[^*\n]+\*\*|__[^_\n]+__|https?:\/\/[^\s<>"']+/gi;
    let cursor = 0;
    for (const match of text.matchAll(expression)) {
      const rawUrl = match[0];
      if (match.index > cursor) parent.append(document.createTextNode(text.slice(cursor, match.index)));
      if ((rawUrl.startsWith("**") && rawUrl.endsWith("**")) || (rawUrl.startsWith("__") && rawUrl.endsWith("__"))) {
        const strong = document.createElement("strong");
        appendLinkedText(strong, rawUrl.slice(2, -2));
        parent.append(strong);
        cursor = match.index + rawUrl.length;
        continue;
      }
      const url = rawUrl.replace(/[.,;!?)}\]]+$/g, "");
      const trailing = rawUrl.slice(url.length);
      try {
        const parsed = new URL(url);
        if (parsed.protocol === "http:" || parsed.protocol === "https:") {
          const link = document.createElement("a");
          link.href = parsed.href;
          link.target = "_blank";
          link.rel = "noopener noreferrer";
          link.className = "answer-link";
          link.textContent = url;
          parent.append(link, document.createTextNode(trailing));
        } else {
          parent.append(document.createTextNode(rawUrl));
        }
      } catch {
        parent.append(document.createTextNode(rawUrl));
      }
      cursor = match.index + rawUrl.length;
    }
    if (cursor < text.length) parent.append(document.createTextNode(text.slice(cursor)));
  };
  const renderAnswer = (body, text) => {
    let listNode = null;
    let listKind = "";
    let lastOrderedNumber = 0;
    let lastListItem = null;
    String(text).replace(/^\s*Best matching knowledge-base result \(not AI-generated\):\s*/i, '').split(/\r?\n/).forEach((line) => {
      if (!line.trim()) {
        return;
      }
      const sourceTitle = line.match(/^\s*\*\*([^*\n]+)\*\*\s*$/);
      if (sourceTitle) {
        listNode = null;
        listKind = "";
        lastOrderedNumber = 0;
        lastListItem = null;
        const element = document.createElement("h3");
        element.className = "source-title";
        appendLinkedText(element, sourceTitle[1]);
        body.append(element);
        return;
      }
      const heading = line.match(/^#{1,3}\s+(.+)$/) || line.match(/^\s*([A-Z][^.!?]{0,57}:)\s*$/);
      if (heading) {
        listNode = null;
        listKind = "";
        lastOrderedNumber = 0;
        lastListItem = null;
        const element = document.createElement("h3");
        appendLinkedText(element, heading[1]);
        body.append(element);
        return;
      }
      const item = line.match(/^\s*(?:[-*]\s+|(\d+)\.\s+)(.+)$/);
      if (item) {
        const kind = item[1] ? "ol" : "ul";
        if (!listNode || listKind !== kind) {
          listNode = document.createElement(kind);
          listKind = kind;
          body.append(listNode);
        }
        const entry = document.createElement("li");
        if (kind === "ol" && item[1]) {
          const requestedNumber = Number(item[1]);
          const displayNumber = requestedNumber <= lastOrderedNumber ? lastOrderedNumber + 1 : requestedNumber;
          entry.value = displayNumber;
          lastOrderedNumber = displayNumber;
        }
        appendLinkedText(entry, item[2]);
        listNode.append(entry);
        lastListItem = entry;
        return;
      }
      if (lastListItem && /^(Position|Qualifications|Education(?: and qualifications)?|MC Portal projects):/i.test(line.trim())) {
        const detail = document.createElement("p");
        appendLinkedText(detail, line);
        lastListItem.append(detail);
        return;
      }
      listNode = null;
      listKind = "";
      lastListItem = null;
      const paragraph = document.createElement("p");
      appendLinkedText(paragraph, line);
      body.append(paragraph);
    });
  };
  const answerModeLabel = (mode) => ({
    greeting: ["Greeting", "mode-general"],
    "ai-general": ["General AI - not verified CCS information", "mode-general"],
    ai: ["AI answer - based on CCS sources", "mode-grounded"],
    "knowledge-base": ["Knowledge base answer", "mode-grounded"],
    announcement: ["Published announcement", "mode-announcement"],
    unverified: ["No verified CCS match", "mode-unverified"],
    "legacy-sourced": ["References saved", "mode-grounded"],
  })[mode] || null;
  const addMessage = (sender, text, sources = [], mode = "") => {
    welcome?.remove();
    const article = document.createElement("article");
    article.className = `message ${sender}`;
    let followUp = null;
    const meta = document.createElement("div");
    meta.className = "message-meta";
    const badge = document.createElement("span");
    badge.className = "message-badge";
    badge.textContent = sender === "student" ? "Y" : "C";
    const label = document.createElement("span");
    label.textContent = sender === "student" ? "You" : "COMSAI";
    const time = document.createElement("time");
    time.dateTime = new Date().toISOString();
    time.textContent = new Intl.DateTimeFormat(undefined, {
      hour: "numeric",
      minute: "2-digit",
    }).format(new Date());
    meta.append(badge, label);
    const modeInfo = sender === "assistant" ? answerModeLabel(mode) : null;
    if (modeInfo) {
      const modeBadge = document.createElement("span");
      modeBadge.className = `message-mode ${modeInfo[1]}`;
      modeBadge.textContent = modeInfo[0];
      meta.append(modeBadge);
    }
    meta.append(time);
    const body = document.createElement("div");
    body.className = "message-body";
    renderAnswer(body, text);
    article.append(meta, body);
    if (sources.length) {
      const sourceRow = document.createElement("div");
      sourceRow.className = "sources";
      const seenSourceTitles = new Set();
      sources.forEach((source) => {
        const sourceTitle = String(source.title || "").trim();
        const sourceKey = sourceTitle.toLocaleLowerCase();
        if (!sourceTitle || seenSourceTitles.has(sourceKey)) return;
        seenSourceTitles.add(sourceKey);
        const item = source.url
          ? document.createElement("a")
          : document.createElement("span");
        item.className = source.url ? "source-link" : "source-label";
        item.textContent = sourceTitle;
        if (source.url) {
          item.href = source.url;
          item.target = "_blank";
          item.rel = "noopener noreferrer";
        }
        sourceRow.append(item);
      });
      article.append(sourceRow);
    }
    if (sender === "assistant") {
      followUp = document.createElement("div");
      followUp.className = "message-followup";
      const followUpText = document.createElement("p");
      followUpText.textContent = "Do you have another concern? If not, you can send feedback about COMSAI.";
      const followUpButton = document.createElement("button");
      followUpButton.type = "button";
      followUpButton.className = "message-feedback-button";
      followUpButton.dataset.openStudentFeedback = "";
      followUpButton.setAttribute("aria-controls", "student-feedback-form");
      followUpButton.textContent = "Send student feedback";
      followUp.append(followUpText, followUpButton);
    }
    list.append(article);
    if (followUp) list.append(followUp);
    scrollToBottom();
  };

  list.addEventListener("click", (event) => {
    if (!(event.target instanceof Element) || !event.target.closest("[data-open-student-feedback]")) return;
    const feedbackBox = document.querySelector(".student-feedback-box");
    const feedbackInput = document.querySelector("#student-feedback");
    const sidePanel = feedbackBox?.closest(".side-panel");
    if (!feedbackBox || !sidePanel) return;
    feedbackBox.open = true;
    const top = sidePanel.scrollTop + feedbackBox.getBoundingClientRect().top - sidePanel.getBoundingClientRect().top;
    sidePanel.scrollTo({ top, behavior: "smooth" });
    window.requestAnimationFrame(() => feedbackInput?.focus({ preventScroll: true }));
  });

  const showError = (text) => {
    const note = document.createElement("div");
    note.className = "error-message";
    note.setAttribute("role", "alert");
    note.textContent = text;
    list.append(note);
    scrollToBottom();
  };

  const parseApiResponse = async (response) => {
    const contentType = response.headers.get("content-type") || "";
    if (!contentType.toLowerCase().includes("application/json")) {
      if (response.status === 403) {
        throw new Error("The hosting server denied the chat API (HTTP 403). Check that api/chat.php is uploaded with readable permissions, or contact your host to remove the block.");
      }
      throw new Error(`The server returned an unexpected response (HTTP ${response.status}). Please try again later.`);
    }
    try {
      return await response.json();
    } catch {
      throw new Error("The chat server returned invalid JSON. Please try again later.");
    }
  };

  const showQuotaNotice = (text) => {
    const note = document.createElement("div");
    note.className = "quota-notice";
    note.setAttribute("role", "status");
    note.textContent = text;
    list.append(note);
    scrollToBottom();
  };

  const showMaintenanceNotice = (text) => {
    maintenanceMode = true;
    input.disabled = true;
    sendButton.disabled = true;
    document.querySelector('#new-chat')?.setAttribute('disabled', '');
    document.querySelectorAll('[data-question]').forEach((button) => { button.disabled = true; });
    const note = document.createElement('div');
    note.className = 'maintenance-notice';
    note.setAttribute('role', 'status');
    note.textContent = text;
    list.append(note);
    scrollToBottom();
  };

  const send = async (question, categoryId = null) => {
    const message = question.trim();
    if (!message || busy || message.length > 1000) return;
    busy = true;
    await historyReady;
    input.value = "";
    input.style.height = "auto";
    count.textContent = "0 / 1000";
    addMessage("student", message);
    const typing = document.createElement("div");
    typing.className = "typing";
    typing.textContent = "COMSAI is thinking";
    typing.setAttribute("role", "status");
    list.append(typing);
    sendButton.disabled = true;
    try {
      const response = await fetch("api/chat.php", {
        method: "POST",
        headers: { "Content-Type": "application/json", "X-CSRF-Token": csrf },
        body: JSON.stringify({ action: "message", question: message, category_id: categoryId }),
      });
      const payload = await parseApiResponse(response);
      typing.remove();
      if (payload.code === "maintenance") {
        showMaintenanceNotice(payload.error || "COMSAI is under maintenance. Please check back later.");
        return;
      }
      if (payload.code === "daily_student_limit") {
        showQuotaNotice(payload.error || "COMSAI is unavailable for new students today. Please come back tomorrow.");
        return;
      }
      if (!response.ok || !payload.ok)
        throw new Error(
          payload.error ||
            "The assistant could not answer right now. Please try again.",
        );
      if (Array.isArray(payload.messages)) {
        payload.messages.forEach((message) => addMessage("assistant", message.answer, message.sources || [], payload.mode || ""));
      } else {
        addMessage("assistant", payload.answer, payload.sources || [], payload.mode || "");
      }
    } catch (error) {
      typing.remove();
      showError(
        error.message ||
          "Connection problem. Check that Apache and MySQL are running, then try again.",
      );
    } finally {
      busy = false;
      sendButton.disabled = maintenanceMode;
      if (!maintenanceMode) input.focus();
    }
  };

  form.addEventListener("submit", (event) => {
    event.preventDefault();
    send(input.value);
  });
  input.addEventListener("input", () => {
    count.textContent = `${input.value.length} / 1000`;
    input.style.height = "auto";
    input.style.height = `${Math.min(input.scrollHeight, 140)}px`;
  });
  input.addEventListener("keydown", (event) => {
    if (event.key === "Enter" && !event.shiftKey) {
      event.preventDefault();
      form.requestSubmit();
    }
  });
  document
    .querySelectorAll("[data-question]")
    .forEach((button) =>
      button.addEventListener("click", () => send(button.dataset.question, button.dataset.categoryId || null)),
    );
  document.querySelector("#new-chat").addEventListener("click", async () => {
    if (busy) return;
    try {
      const response = await fetch("api/chat.php", {
        method: "POST",
        headers: { "Content-Type": "application/json", "X-CSRF-Token": csrf },
        body: JSON.stringify({ action: "clear" }),
      });
      if (!response.ok) {
        const payload = await parseApiResponse(response);
        if (payload?.code === "maintenance") {
          showMaintenanceNotice(payload.error || "COMSAI is under maintenance. Please check back later.");
          return;
        }
        throw new Error(payload?.error || "Could not start a new chat. Please refresh the page.");
      }
      list.replaceChildren();
      const fresh = welcome?.cloneNode(true);
      if (fresh) list.append(fresh);
    } catch (error) {
      showError(error.message || "Could not start a new chat. Please refresh the page.");
    }
  });
  const feedbackForm = document.querySelector('#student-feedback-form');
  const feedbackInput = document.querySelector('#student-feedback');
  const feedbackStatus = document.querySelector('#student-feedback-status');
  const feedbackButton = feedbackForm?.querySelector('button[type="submit"]');
  const feedbackDropdown = document.querySelector('.student-feedback-box');
  const feedbackSummary = feedbackDropdown?.querySelector('summary');
  const feedbackThankYou = document.querySelector('#student-feedback-thank-you');
  const updateFeedbackValidation = () => {
    if (!feedbackInput || !feedbackButton || !feedbackStatus) return;
    const value = feedbackInput.value;
    const valid = value.trim().length > 0 && value.length <= 3000;
    feedbackButton.disabled = !valid;
    if (!value.trim()) feedbackStatus.textContent = 'Enter feedback before submitting.';
    else if (value.length > 3000) feedbackStatus.textContent = 'Feedback must be 3,000 characters or fewer.';
    else if (/^Enter feedback|^Feedback must be/.test(feedbackStatus.textContent)) feedbackStatus.textContent = '';
  };
  feedbackInput?.addEventListener('input', updateFeedbackValidation);
  updateFeedbackValidation();
  feedbackSummary?.addEventListener('click', (event) => {
    if (feedbackDropdown?.dataset.submitted === 'true') event.preventDefault();
  });
  document.addEventListener('click', (event) => {
    if (
      feedbackDropdown?.open &&
      !feedbackDropdown.contains(event.target) &&
      !(event.target instanceof Element && event.target.closest('[data-open-student-feedback]'))
    ) {
      feedbackDropdown.open = false;
    }
  });
  feedbackForm?.addEventListener('submit', async (event) => {
    event.preventDefault();
    const button = feedbackButton;
    if (!feedbackInput || !button || !feedbackStatus) return;
    button.disabled = true;
    feedbackStatus.textContent = 'Sending feedback…';
    try {
      const response = await fetch('api/feedback.php', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json', 'X-CSRF-Token': csrf },
        body: JSON.stringify({ feedback: feedbackInput.value }),
      });
      const payload = await response.json().catch(() => null);
      if (!response.ok || !payload?.ok) throw new Error(payload?.error || 'Feedback could not be saved. Please try again.');
      feedbackForm.reset();
      feedbackForm.dataset.submitted = 'true';
      feedbackInput.disabled = true;
      button.disabled = true;
      if (feedbackDropdown) {
        feedbackDropdown.dataset.submitted = 'true';
        feedbackDropdown.open = false;
      }
      feedbackSummary?.setAttribute('aria-disabled', 'true');
      feedbackStatus.textContent = '';
      if (feedbackThankYou) {
        feedbackThankYou.textContent = 'THANK YOU FOR YOUR FEEDBACK!';
        feedbackThankYou.hidden = false;
      }
    } catch (error) {
      feedbackStatus.textContent = error.message || 'Feedback could not be saved. Please try again.';
    } finally {
      button.disabled = feedbackForm.dataset.submitted === 'true' || feedbackInput.value.trim().length === 0 || feedbackInput.value.length > 3000;
    }
  });
  historyReady = (async () => {
    const headers = { "Content-Type": "application/json", "X-CSRF-Token": csrf };
    if (new URLSearchParams(location.search).has("new_chat")) {
      const clearResponse = await fetch("api/chat.php", {
        method: "POST",
        headers,
        body: JSON.stringify({ action: "clear" }),
      });
      if (!clearResponse.ok) throw new Error("Could not start a new chat.");
      history.replaceState(null, "", `${location.pathname}${location.hash}`);
    }
    const response = await fetch("api/chat.php", {
      method: "POST",
      headers,
      body: JSON.stringify({ action: "history" }),
    });
    const payload = response.ok ? await response.json() : null;
    if (payload?.ok) payload.messages.forEach((message) => addMessage(
      message.sender === "student" ? "student" : "assistant",
      message.message,
      message.sources || [],
      message.response_mode || "",
    ));
  })().catch(() => {});
})();
