use crate::db::models::SpontaneousActivity;
use crate::db::get_conn;
use rusqlite::{params, Result};
use super::{generate_id, current_timestamp, calculate_hash};

pub fn create_activity(title: String, description: Option<String>, points: i32, created_by: String, image_path: Option<String>) -> Result<SpontaneousActivity> {
    let id = generate_id();
    let now = current_timestamp();
    let state_hash = calculate_hash(&id, now, &created_by);

    let activity = SpontaneousActivity {
        id: id.clone(),
        title: title.clone(),
        description: description.clone(),
        points,
        created_at: now,
        updated_at: now,
        created_by: created_by.clone(),
        image_path: image_path.clone(),
        state_hash: state_hash.clone(),
    };

    get_conn(|conn| {
        conn.execute(
            "INSERT INTO spontaneous_activities (id, title, description, points, created_at, updated_at, created_by, image_path, state_hash)
             VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9)",
            params![id, title, description, points, now, now, created_by, image_path, state_hash],
        )
    })?;

    Ok(activity)
}

pub fn get_activities() -> Result<Vec<SpontaneousActivity>> {
    get_conn(|conn| {
        let mut stmt = conn.prepare("SELECT id, title, description, points, created_at, updated_at, created_by, image_path, state_hash FROM spontaneous_activities")?;
        let activity_iter = stmt.query_map([], |row| {
            Ok(SpontaneousActivity {
                id: row.get(0)?,
                title: row.get(1)?,
                description: row.get(2)?,
                points: row.get(3)?,
                created_at: row.get(4)?,
                updated_at: row.get(5)?,
                created_by: row.get(6)?,
                image_path: row.get(7)?,
                state_hash: row.get(8)?,
            })
        })?;

        let mut activities = Vec::new();
        for activity in activity_iter {
            activities.push(activity?);
        }
        Ok(activities)
    })
}
