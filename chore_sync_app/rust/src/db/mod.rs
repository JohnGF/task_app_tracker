pub mod models;
pub mod schema;

use rusqlite::{Connection, Result};
use std::sync::Mutex;

lazy_static::lazy_static! {
    static ref DB_CONN: Mutex<Option<Connection>> = Mutex::new(None);
}

pub fn init_db(db_path: &str) -> Result<()> {
    let conn = Connection::open(db_path)?;
    crate::db::schema::create_tables(&conn)?;
    *DB_CONN.lock().unwrap() = Some(conn);
    Ok(())
}

pub fn get_conn<F, R>(f: F) -> R
where
    F: FnOnce(&Connection) -> R,
{
    let guard = DB_CONN.lock().unwrap();
    let conn = guard.as_ref().expect("Database not initialized");
    f(conn)
}
