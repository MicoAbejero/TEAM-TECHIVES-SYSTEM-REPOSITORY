CREATE TABLE IF NOT EXISTS admin_activity_state (
    admin_id INT UNSIGNED NOT NULL,
    last_seen_chat_message_id BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (admin_id),
    CONSTRAINT fk_activity_state_admin FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
