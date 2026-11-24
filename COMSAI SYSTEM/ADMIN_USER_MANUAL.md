# COMSAI Administrator User Manual

This manual explains how authorized staff can manage the COMSAI student information assistant. Use only verified, current CCS information. Menu items and available actions can differ by account role.

## Sign in

1. Open the online administrator sign-in page: `https://comsaiproject.com/login.php`.
2. Enter your administrator email and password, then select **Sign in**.
3. There is no public administrator registration. Accounts must be provisioned by authorized staff.
4. On first sign-in, change your password from **Administrator account**.

There are no default administrator credentials. Provision accounts through the setup process, and do not reuse demonstration credentials in a public deployment.

## Navigation and roles

The sidebar links to **Dashboard**, **Knowledge base**, **Announcements**, **Categories**, **Chatbot activity**, **Student Feedback**, and **Administrator account**. The **Student interface** menu opens the student panel in a new tab and shows whether it is enabled.

- **Administrators** can publish and delete knowledge entries and announcements, manage categories, view and delete activity and feedback records, and enable or disable the student interface.
- **Editors** can create and edit knowledge entries and announcements, but their work is saved as drafts for an administrator to review. Editors do not have access to category management, feedback, or chatbot activity.

## Dashboard

The dashboard summarizes knowledge entries, published items, drafts, and recorded student questions. Use **Add information** to start a knowledge entry. Recent updates and quick links help you find commonly used sections.

## Manage the knowledge base

1. Open **Knowledge base**.
2. Add an entry or choose **Edit** beside an existing one.
3. Provide a clear **Title**, **Category**, **Source title**, and **Verified information**. Add the source URL when available.
4. Set publication and expiration date/time if the information is time-sensitive. Ensure expiration is later than publication.
5. Add only relevant alternate keywords or example questions (up to 14 phrases). The title is added automatically. Do not add unrelated popular terms.
6. Administrators can select **Draft** or **Published**. Editors save drafts for administrator review.
7. Select **Save draft** or **Publish** as appropriate. Confirm bulk actions carefully.

Drafts are not used in student answers. Published entries are eligible only while within their effective and expiration dates. Verify the source and accuracy before publishing; update or unpublish outdated information promptly.

Use the search field and filters to locate entries by text, status, or category. The sort control can order entries by latest, oldest, or title. Administrators can select multiple entries to publish, unpublish, or delete them. Deletion is permanent.

## Manage announcements

Create an announcement with a title and clear message. Add an official source URL when available, then set the publication and expiration date/time. Administrators can publish; editor submissions remain drafts for review. Published announcements outside their date range are not treated as current chatbot information.

Use search, status filters, and sorting to locate notices. Administrator bulk actions can publish, unpublish, or delete selected announcements. Check the content and dates before publishing.

## Manage categories

Administrators can add, edit, search, and sort categories. The **Student panel** column indicates whether a category appears in the student interface. Select categories and use the bulk action to show or hide them there.

A category cannot be deleted while it contains knowledge entries. Move or delete those entries first. Deleting a category is permanent.

## Student interface availability

Open the **Student interface** menu in the sidebar to launch the student page and view its current status. Administrators can select **Disable Interface** during planned maintenance; students will see a maintenance message and cannot submit questions. Select **Enable Student Interface** when service is ready again.

## Review chatbot activity

Open **Chatbot activity** to see aggregate question counts and recent student questions. Search and sort the recent list as needed. Select questions and choose **Delete** to remove selected records.

Activity timestamps are displayed in Philippine time using the `Asia/Manila` timezone (UTC+08:00).

Questions are stored for service monitoring and are not linked to student profiles, but the text itself may contain personal information. Do not use this page to identify students. Handle records only for legitimate service purposes.

## See active administrators

The top-right dashboard area shows the signed-in administrator name and role. Select **See active users** to open the list of administrators who are currently active.

- A green status dot identifies the active-user control.
- An administrator is considered active when their admin page has sent a heartbeat within the last five minutes.
- The list refreshes automatically while the administrator page is open.
- Administrators who have not sent a heartbeat for more than five minutes are no longer shown as active.

Use this indicator to see which authorized administrators are currently working in the admin interface. It does not replace the **Log out** control. Always sign out when finished, especially on a shared computer.

## Review student feedback

Open **Student Feedback** to search and sort anonymously submitted feedback. Select entries and choose **Delete** to remove them. Feedback is not a channel for identifying students; do not attempt to infer who submitted it.

## Change your password and sign out

1. Open **Administrator account**.
2. Enter the email address shown for your account, your current password, and a new password twice.
3. Use a new password between 12 and 200 characters, then select **Update password**.
4. Select **Log out** in the sidebar when finished, especially on a shared computer.

## Privacy and operational care

- Never put student names, IDs, contact details, or other sensitive information into knowledge entries, feedback, or chat examples.
- Student questions and answers may be retained and visible to authorized administrators. The application uses anonymous session tokens; anonymity does not mean chat text is private from administrators.
- Publish only information verified against official CCS sources. Check source URLs and effective dates regularly.
- If optional OpenAI features are enabled, questions and matching approved source text may be sent to OpenAI. Follow institutional privacy approval and policy before enabling them.
- Keep account credentials private. Rotate demo credentials and use strong, unique passwords before making the site public.

## Common issues

- **Sign-in fails:** Check the email/password, confirm the account exists and is active, and wait 15 minutes if sign-in attempts have been rate-limited.
- **A saved entry does not appear to students:** Confirm it is published, its effective date has passed, its expiration date has not passed, and its category is shown in the student panel.
- **Students see maintenance mode:** An administrator may have disabled the student interface. Re-enable it only after confirming the service is ready.
- **Changes fail to save or the page reports a service problem:** Refresh and retry. If the issue continues, ask the site administrator to check the database connection and server logs.
