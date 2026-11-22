CREATE TABLE IF NOT EXISTS student_feedback (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    feedback MEDIUMTEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id), KEY idx_student_feedback_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
