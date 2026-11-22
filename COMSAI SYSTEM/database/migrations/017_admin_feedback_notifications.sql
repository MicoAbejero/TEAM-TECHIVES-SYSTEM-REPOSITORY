CREATE TABLE IF NOT EXISTS admin_feedback_state (
    admin_id INT UNSIGNED NOT NULL,
    last_seen_feedback_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (admin_id),
    CONSTRAINT fk_feedback_state_admin FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
