ALTER TABLE categories
    ADD COLUMN show_in_student_panel TINYINT(1) NOT NULL DEFAULT 1 AFTER description;
