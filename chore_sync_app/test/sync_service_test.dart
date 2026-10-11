import 'package:flutter_test/flutter_test.dart';
import 'package:chore_sync_app/services/sync_service.dart';

void main() {
  group('SyncService Tests', () {
    late SyncService syncService;

    setUp(() {
      syncService = SyncService();
    });

    test('Initial sync state is false', () {
      expect(syncService.isSynced, false);
    });

    test('syncWithLocalDevice sets isSynced to true', () async {
      await syncService.syncWithLocalDevice();
      expect(syncService.isSynced, true);
    });

    test('resetSyncState sets isSynced back to false', () async {
      await syncService.syncWithLocalDevice();
      expect(syncService.isSynced, true);
      
      syncService.resetSyncState();
      expect(syncService.isSynced, false);
    });
  });
}
