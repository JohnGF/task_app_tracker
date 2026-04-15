use aes_gcm::{
    aead::{Aead, AeadCore, KeyInit, OsRng},
    Aes256Gcm, Key, Nonce
};
use crate::sync::payloads::{SyncPayload, EncryptedPayload};
use serde_json;

pub fn encrypt_payload(payload: &SyncPayload, encryption_key: &[u8; 32]) -> Result<EncryptedPayload, String> {
    let key = Key::<Aes256Gcm>::from_slice(encryption_key);
    let cipher = Aes256Gcm::new(key);
    let nonce = Aes256Gcm::generate_nonce(&mut OsRng); // 96-bits; unique per message

    let payload_bytes = serde_json::to_vec(payload).map_err(|e| e.to_string())?;

    let ciphertext = cipher.encrypt(&nonce, payload_bytes.as_ref())
        .map_err(|e| e.to_string())?;

    Ok(EncryptedPayload {
        payload: ciphertext,
        nonce: nonce.to_vec(),
    })
}

pub fn decrypt_payload(encrypted: &EncryptedPayload, encryption_key: &[u8; 32]) -> Result<SyncPayload, String> {
    let key = Key::<Aes256Gcm>::from_slice(encryption_key);
    let cipher = Aes256Gcm::new(key);
    let nonce = Nonce::from_slice(&encrypted.nonce);

    let plaintext = cipher.decrypt(nonce, encrypted.payload.as_ref())
        .map_err(|e| e.to_string())?;

    let payload: SyncPayload = serde_json::from_slice(&plaintext)
        .map_err(|e| e.to_string())?;

    Ok(payload)
}

// TODO: Outline for embedded P2P sync (e.g., using a background thread and TCP/UDP sockets to broadcast presence, handshake, and swap EncryptedPayloads)
// - Start a local listener
// - Broadcast over local network
// - Connect and compare state hashes
// - Send updated items in an EncryptedPayload
