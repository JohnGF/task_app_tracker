use crate::db::models::Chore;
use crate::db::get_conn;
use rusqlite::{params, Result, OptionalExtension};
use super::{generate_id, current_timestamp, calculate_hash};

pub fn create_chore(title: String, description: Option<String>, points: i32, created_by: String, image_path: Option<String>) -> Result<Chore> {
    let id = generate_id();
    let now = current_timestamp();
    let state_hash = calculate_hash(&id, now, &created_by);
    let status = "proposed".to_string();

    let chore = Chore {
        id: id.clone(),
        title: title.clone(),
        description: description.clone(),
        points,
        status: status.clone(),
        created_at: now,
        updated_at: now,
        created_by: created_by.clone(),
        image_path: image_path.clone(),
        state_hash: state_hash.clone(),
    };

    get_conn(|conn| {
        conn.execute(
            "INSERT INTO chores (id, title, description, points, status, created_at, updated_at, created_by, image_path, state_hash)
             VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10)",
            params![id, title, description, points, status, now, now, created_by, image_path, state_hash],
        )
    })?;

    Ok(chore)
}

pub fn get_chores() -> Result<Vec<Chore>> {
    get_conn(|conn| {
        let mut stmt = conn.prepare("SELECT id, title, description, points, status, created_at, updated_at, created_by, image_path, state_hash FROM chores")?;
        let chore_iter = stmt.query_map([], |row| {
            Ok(Chore {
                id: row.get(0)?,
                title: row.get(1)?,
                description: row.get(2)?,
                points: row.get(3)?,
                status: row.get(4)?,
                created_at: row.get(5)?,
                updated_at: row.get(6)?,
                created_by: row.get(7)?,
                image_path: row.get(8)?,
                state_hash: row.get(9)?,
            })
        })?;

        let mut chores = Vec::new();
        for chore in chore_iter {
            chores.push(chore?);
        }
        Ok(chores)
    })
}

pub fn update_chore_status(id: String, new_status: String) -> Result<Option<Chore>> {
    let now = current_timestamp();

    get_conn(|conn| {
        let mut stmt = conn.prepare("SELECT created_by FROM chores WHERE id = ?1")?;
        let created_by: Option<String> = stmt.query_row(params![&id], |row| row.get(0)).optional()?;

        if let Some(creator) = created_by {
            let new_hash = calculate_hash(&id, now, &creator);
            conn.execute(
                "UPDATE chores SET status = ?1, updated_at = ?2, state_hash = ?3 WHERE id = ?4",
                params![new_status, now, new_hash, id],
            )?;

            // Fetch the updated chore
            let mut stmt = conn.prepare("SELECT id, title, description, points, status, created_at, updated_at, created_by, image_path, state_hash FROM chores WHERE id = ?1")?;
            let chore = stmt.query_row(params![&id], |row| {
                Ok(Chore {
                    id: row.get(0)?,
                    title: row.get(1)?,
                    description: row.get(2)?,
                    points: row.get(3)?,
                    status: row.get(4)?,
                    created_at: row.get(5)?,
                    updated_at: row.get(6)?,
                    created_by: row.get(7)?,
                    image_path: row.get(8)?,
                    state_hash: row.get(9)?,
                })
            })?;
            Ok(Some(chore))
        } else {
            Ok(None)
        }
    })
}
