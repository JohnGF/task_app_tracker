class SyncService {
  bool _isSynced = false;

  bool get isSynced => _isSynced;

  Future<void> syncWithLocalDevice() async {
    // Simulate syncing delay
    await Future.delayed(const Duration(milliseconds: 100));
    _isSynced = true;
  }

  void resetSyncState() {
    _isSynced = false;
  }
}
