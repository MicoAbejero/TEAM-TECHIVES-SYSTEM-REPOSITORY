CREATE TABLE IF NOT EXISTS knowledge_embeddings (
    knowledge_base_id INT UNSIGNED NOT NULL,
    embedding_model VARCHAR(80) NOT NULL,
    content_hash CHAR(64) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    embedding_vector MEDIUMBLOB NOT NULL,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (knowledge_base_id),
    CONSTRAINT fk_knowledge_embedding_entry
        FOREIGN KEY (knowledge_base_id) REFERENCES knowledge_base(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
