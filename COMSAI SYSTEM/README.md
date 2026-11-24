# COMSAI SYSTEM

A PHP and MySQL-powered student information assistant for the College of Computer Studies. It gives students a public chat experience for verified CCS information and gives administrators a secure dashboard for managing the knowledge base, announcements, feedback, and system activity.

## Overview

COMSAI is designed to answer student questions using verified, published content rather than unreviewed static text. The application supports anonymous student chat, category browsing, source references, and optional AI-assisted retrieval. Administrators can manage knowledge entries, categories, announcements, and feedback from a protected admin area, while editor and administrator roles maintain separate permissions.

This project is a standalone PHP application with no framework dependency and is intended to run online on a PHP-enabled hosting environment. The production deployment uses the hosted domain, server-side environment variables, and a MySQL/MariaDB database provisioned by the hosting provider.

## Features

- Public student-facing chat interface
- Anonymous student questions and feedback
- Published knowledge-base search with reference support
- Admin dashboard for categories, announcements, and knowledge entries
- Role-based permissions for administrators and editors
- Optional OpenAI Responses API integration
- Optional semantic retrieval using embeddings
- Database-backed testing and maintenance scripts

## Tech Stack

- PHP 8.2+
- MySQL / MariaDB
- PDO for database access
- HTML, CSS, and JavaScript
- Apache with `.htaccess` support
- PHP-enabled online hosting environment

## Project Structure

- `index.php` — student chat interface
- `login.php` and `logout.php` — admin sign-in and sign-out
- `admin/` — administrator dashboard and management pages
- `api/` — chat and feedback endpoints
- `includes/`, `config/`, `connect.php` — shared logic and configuration
- `assets/` — styles, scripts, and static files
- `database/` — schema and migration files
- `bin/` — setup and maintenance tools
- `tests/` — database-backed test runner
- `.env.example` — sample environment configuration
- `ADMIN_USER_MANUAL.md` — admin documentation
- `STUDENT_USER_MANUAL.md` — student documentation

## Online deployment requirements

Before deploying the project online, make sure the hosting account provides:

- PHP 8.2 or newer with `pdo_mysql`, `mbstring`, `curl`, and `openssl`
- MySQL or MariaDB database access
- Apache with `.htaccess` support enabled
- HTTPS enabled for the production domain
- Secure server-side environment variable configuration
- Optional: an OpenAI API key when AI features are enabled

## Online deployment

1. Create a MySQL or MariaDB database in the hosting control panel.
2. Import `database/new_comsai_db.sql` using the hosting provider's online database management tool.
3. Upload the application files to the website's public directory.
4. Copy `.env.example` to `.env` on the server and enter the database credentials provided by the hosting account:
   - `DB_HOST`
   - `DB_PORT`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PASS`
5. Configure the optional OpenAI settings in the server-side `.env` file:
   - `OPENAI_API_KEY`
   - `OPENAI_EMBEDDINGS_ENABLED=1` only when semantic retrieval is enabled
6. Create the first administrator account using the hosting account's PHP command-line or server task feature, or through the approved application setup process.
7. Verify the database connection and run the project tests using the hosting account's PHP command-line or server task feature.
8. Open the production URLs below and confirm that the student page and administrator dashboard load over HTTPS.

## Configuration

The application expects a server-side `.env` file in the project root. Do not commit this file to version control or expose it through the public website.

Example structure:

```env
DB_HOST=your-hosting-database-host
DB_PORT=3306
DB_NAME=your-hosting-database-name
DB_USER=your-hosting-database-user
DB_PASS=your-hosting-database-password
OPENAI_API_KEY=your-openai-api-key
OPENAI_EMBEDDINGS_ENABLED=0
```

Use the exact database host, port, name, username, and password shown by the hosting provider. Ensure PHP has `pdo_mysql` enabled and Apache allows `.htaccess` rules.

Application timestamps, including chatbot activity and student feedback, are displayed in Philippine time using the `Asia/Manila` timezone (UTC+08:00).

## Online URLs

- Student chat: `https://comsaiproject.com/`
- Admin login: `https://comsaiproject.com/login.php`
- Admin dashboard: `https://comsaiproject.com/admin/index.php`
- Database management: use the database management tool provided in the hosting control panel

All public access should use HTTPS. Keep server configuration and deployment paths on the online hosting account.

## Usage

### Student experience

Students can:

- Ask questions without creating an account
- Browse visible categories and topics
- View source references for supported answers
- Submit anonymous feedback
- See clearly labeled knowledge-base responses
- Continue the conversation after an answer if they have another concern
- Send feedback to COMSAI when they are satisfied or want to report an issue, if they do not have another question

After answering a student question, COMSAI may prompt the student to ask another question if they have another concern. If no further concern exists, the student may send feedback about the COMSAI experience or the answer quality.

### Administrator experience

Authorized staff can:

- Manage the knowledge base and categories
- Review and publish announcements
- Moderate student feedback
- Inspect chatbot activity and notifications
- Control student panel visibility and permissions

## Database Updates

For existing installations, use the migration files in `database/migrations/` to update the database structure.

Important migrations include:

- `001_chat_message_sources.sql`
- `002_ccs_council_officers.sql`
- `006_knowledge_datetime.sql`
- `016_student_feedback.sql`
- `017_admin_feedback_notifications.sql`
- `018_admin_activity_notifications.sql`
- `019_knowledge_embeddings.sql`
- `020_category_student_panel_visibility.sql`

Import each migration once using the hosting provider's online database management tool. Do not repeat a migration that is already part of the current full schema.

## Maintenance and cleanup

The project includes utility scripts for ongoing maintenance:

- `bin/normalize_knowledge_terms.php` — clean and normalize knowledge terms
- `bin/rebuild_knowledge_embeddings.php` — rebuild semantic embeddings
- `bin/purge_expired_data.php` — remove expired sessions and old audit rows

Run the cleanup script when needed after knowledge updates or when managing long-lived data. Use the hosting account's PHP command-line or server task feature to run maintenance scripts online.

## Privacy and Security

- PDO queries use prepared statements
- Admin writes use CSRF validation and server-side authorization checks
- Passwords are stored using `password_hash()` and verified with `password_verify()`
- `.env` and sensitive setup files should remain protected by Apache rules
- OpenAI-enabled requests send data externally when configured; obtain the required institutional approval before using the feature with real student data
- Never publish live student data or production credentials in public-facing documentation

## Documentation

Read the application manuals for role-specific instructions:

- [Administrator User Manual](ADMIN_USER_MANUAL.md)
- [Student User Manual](STUDENT_USER_MANUAL.md)

## Notes

This project contains a fictional sample knowledge entry that must be replaced by verified CCS content before it is considered production-ready. Until approved content is added, the chatbot should clearly state that it cannot verify an answer.

The project is prepared for online deployment on a PHP-enabled hosting account. Review the production configuration, database credentials, HTTPS setup, access controls, and approved CCS content before making the application publicly available.
