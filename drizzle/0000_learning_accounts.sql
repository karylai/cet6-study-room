CREATE TABLE IF NOT EXISTS users (
 id TEXT PRIMARY KEY NOT NULL,
 email TEXT UNIQUE NOT NULL,
 password_hash TEXT NOT NULL,
 password_salt TEXT NOT NULL,
 password_iterations INTEGER NOT NULL DEFAULT 100000,
 nickname TEXT NOT NULL,
 exam_date TEXT NOT NULL DEFAULT '',
 daily_words INTEGER NOT NULL DEFAULT 5,
 daily_minutes INTEGER NOT NULL DEFAULT 30,
 created_at INTEGER NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS sessions (
 token_hash TEXT PRIMARY KEY NOT NULL,
 user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 expires_at INTEGER NOT NULL,
 created_at INTEGER NOT NULL
);
--> statement-breakpoint
CREATE INDEX IF NOT EXISTS sessions_user_idx ON sessions(user_id);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS user_state (
 user_id TEXT PRIMARY KEY NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 state_json TEXT NOT NULL,
 revision INTEGER NOT NULL DEFAULT 1,
 updated_at INTEGER NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS auth_limits (
 limit_key TEXT PRIMARY KEY NOT NULL,
 window_start INTEGER NOT NULL,
 attempts INTEGER NOT NULL DEFAULT 1
);
