# COMSAI SYSTEM

A PHP and MySQL-powered student information assistant for the College of Computer Studies. It gives students a public chat experience for verified CCS information and gives administrators a secure dashboard for managing the knowledge base, announcements, feedback, and system activity.

## Overview

COMSAI is designed to answer student questions using verified, published content rather than unreviewed static text. The application supports anonymous student chat, category browsing, source references, and optional AI-assisted retrieval. Administrators can manage knowledge entries, categories, announcements, and feedback from a protected admin area, while editor and administrator roles maintain separate permissions.

This project is a standalone PHP application with no framework dependency and is intended for local XAMPP-based deployment or a PHP-enabled hosting environment.

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
- XAMPP for local development

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

## Requirements

Before running the project, make sure you have:

- XAMPP with Apache and MySQL/MariaDB running
- PHP 8.2+ with `pdo_mysql` and `mbstring`
- Apache configured to allow `.htaccess` overrides
- phpMyAdmin for database import
- Optional: OpenAI API key and PHP `curl` / `openssl` support

## Installation

1. Start Apache and MySQL in the XAMPP Control Panel.
2. Open phpMyAdmin and import the database file:
   `C:\xampp\htdocs\COMSAI SYSTEM\database\new_comsai_db.sql`
3. Copy `.env.example` to `.env` and update the values for your local database connection:
   - `DB_HOST`
   - `DB_PORT`
   - `DB_NAME`
   - `DB_USER`
   - `DB_PASS`
4. Optionally configure OpenAI settings in `.env`:
   - `OPENAI_API_KEY`
   - `OPENAI_EMBEDDINGS_ENABLED=1` (only if semantic retrieval is enabled)
5. Create the first administrator account:

   `C:\xampp\php\php.exe "C:\xampp\htdocs\COMSAI SYSTEM\bin\create_admin.php"`

6. Verify the database connection:

   `C:\xampp\php\php.exe "C:\xampp\htdocs\COMSAI SYSTEM\bin\test_db.php"`

7. Run the project tests:

   `C:\xampp\php\php.exe "C:\xampp\htdocs\COMSAI SYSTEM\tests\run.php"`

## Configuration

The application expects a server-side `.env` file in the project root. This file should not be committed to version control.

Example values:

```env
DB_HOST=127.0.0.1
DB_PORT=3306
DB_NAME=new_comsai_db
DB_USER=root
DB_PASS=
OPENAI_API_KEY=
OPENAI_EMBEDDINGS_ENABLED=0
```

For shared hosting, create a MySQL database in the hosting control panel and set the exact database credentials in `.env` on the server. Ensure PHP has `pdo_mysql` enabled and Apache allows `.htaccess` rules.

## Local URLs

- Student chat: `http://localhost/COMSAI%20SYSTEM/`
- Admin login: `http://localhost/COMSAI%20SYSTEM/login.php`
- Admin dashboard: `http://localhost/COMSAI%20SYSTEM/admin/index.php`
- phpMyAdmin: `http://localhost/phpmyadmin/`

Note: The directory contains a space in the folder name, so `%20` is used in browser URLs.

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

Import these once in phpMyAdmin for an existing database, and do not repeat a migration that is already part of the current full schema.

## Maintenance and cleanup

The project includes utility scripts for ongoing maintenance:

- `bin\normalize_knowledge_terms.php` — clean and normalize knowledge terms
- `bin\rebuild_knowledge_embeddings.php` — rebuild semantic embeddings
- `bin\purge_expired_data.php` — remove expired sessions and old audit rows

Run the cleanup script when needed after knowledge updates or when managing long-lived data.

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

The project is intended as a local academic demonstration foundation and should be reviewed carefully before deployment to a production or public-facing environment.
