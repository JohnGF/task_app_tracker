pub mod chores;
pub mod activities;
pub mod rewards;

use chrono::Utc;
use sha2::{Digest, Sha256};
use uuid::Uuid;

pub fn generate_id() -> String {
    Uuid::new_v4().to_string()
}

pub fn current_timestamp() -> i64 {
    Utc::now().timestamp_millis()
}

pub fn calculate_hash(id: &str, updated_at: i64, created_by: &str) -> String {
    let mut hasher = Sha256::new();
    let data = format!("{}_{}_{}", id, updated_at, created_by);
    hasher.update(data.as_bytes());
    let result = hasher.finalize();
    hex::encode(result)
}
