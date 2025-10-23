CREATE TABLE change_log (
    entity_type text NOT NULL,
    entity_id text NOT NULL,
    user_id varchar(40) NOT NULL,
    occurred_at timestamp DEFAULT NOW() NOT NULL,
    action text NOT NULL
);
