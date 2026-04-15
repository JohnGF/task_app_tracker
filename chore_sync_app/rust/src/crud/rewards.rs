use crate::db::models::Reward;
use crate::db::get_conn;
use rusqlite::{params, Result};
use super::{generate_id, current_timestamp, calculate_hash};

pub fn create_reward(title: String, cost: i32, created_by: String, image_path: Option<String>) -> Result<Reward> {
    let id = generate_id();
    let now = current_timestamp();
    let state_hash = calculate_hash(&id, now, &created_by);

    let reward = Reward {
        id: id.clone(),
        title: title.clone(),
        cost,
        created_at: now,
        updated_at: now,
        created_by: created_by.clone(),
        image_path: image_path.clone(),
        state_hash: state_hash.clone(),
    };

    get_conn(|conn| {
        conn.execute(
            "INSERT INTO rewards (id, title, cost, created_at, updated_at, created_by, image_path, state_hash)
             VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)",
            params![id, title, cost, now, now, created_by, image_path, state_hash],
        )
    })?;

    Ok(reward)
}

pub fn get_rewards() -> Result<Vec<Reward>> {
    get_conn(|conn| {
        let mut stmt = conn.prepare("SELECT id, title, cost, created_at, updated_at, created_by, image_path, state_hash FROM rewards")?;
        let reward_iter = stmt.query_map([], |row| {
            Ok(Reward {
                id: row.get(0)?,
                title: row.get(1)?,
                cost: row.get(2)?,
                created_at: row.get(3)?,
                updated_at: row.get(4)?,
                created_by: row.get(5)?,
                image_path: row.get(6)?,
                state_hash: row.get(7)?,
            })
        })?;

        let mut rewards = Vec::new();
        for reward in reward_iter {
            rewards.push(reward?);
        }
        Ok(rewards)
    })
}
