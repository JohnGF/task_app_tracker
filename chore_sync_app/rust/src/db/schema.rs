use rusqlite::{Connection, Result};

pub fn create_tables(conn: &Connection) -> Result<()> {
    conn.execute(
        "CREATE TABLE IF NOT EXISTS chores (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            points INTEGER NOT NULL,
            status TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL,
            created_by TEXT NOT NULL,
            image_path TEXT,
            state_hash TEXT NOT NULL
        )",
        [],
    )?;

    conn.execute(
        "CREATE TABLE IF NOT EXISTS spontaneous_activities (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT,
            points INTEGER NOT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL,
            created_by TEXT NOT NULL,
            image_path TEXT,
            state_hash TEXT NOT NULL
        )",
        [],
    )?;

    conn.execute(
        "CREATE TABLE IF NOT EXISTS rewards (
            id TEXT PRIMARY KEY,
            title TEXT NOT NULL,
            cost INTEGER NOT NULL,
            created_at INTEGER NOT NULL,
            updated_at INTEGER NOT NULL,
            created_by TEXT NOT NULL,
            image_path TEXT,
            state_hash TEXT NOT NULL
        )",
        [],
    )?;

    Ok(())
}
