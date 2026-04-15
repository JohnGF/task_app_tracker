use serde::{Deserialize, Serialize};
use crate::db::models::{Chore, SpontaneousActivity, Reward};

#[derive(Debug, Serialize, Deserialize)]
pub struct SyncPayload {
    pub device_id: String,
    pub timestamp: i64,
    pub chores: Vec<Chore>,
    pub activities: Vec<SpontaneousActivity>,
    pub rewards: Vec<Reward>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct EncryptedPayload {
    pub payload: Vec<u8>,
    pub nonce: Vec<u8>,
}
