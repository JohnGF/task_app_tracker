use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Chore {
    pub id: String,
    pub title: String,
    pub description: Option<String>,
    pub points: i32,
    pub status: String, // "proposed", "pending_approval", "done"
    pub created_at: i64,
    pub updated_at: i64,
    pub created_by: String, // user id
    pub image_path: Option<String>,
    pub state_hash: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct SpontaneousActivity {
    pub id: String,
    pub title: String,
    pub description: Option<String>,
    pub points: i32,
    pub created_at: i64,
    pub updated_at: i64,
    pub created_by: String,
    pub image_path: Option<String>,
    pub state_hash: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Reward {
    pub id: String,
    pub title: String,
    pub cost: i32,
    pub created_at: i64,
    pub updated_at: i64,
    pub created_by: String,
    pub image_path: Option<String>,
    pub state_hash: String,
}
