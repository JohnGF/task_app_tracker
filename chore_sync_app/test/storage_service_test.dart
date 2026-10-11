import 'package:flutter_test/flutter_test.dart';
import 'package:chore_sync_app/services/storage_service.dart';

void main() {
  group('StorageService Tests', () {
    late StorageService storage;

    setUp(() {
      storage = StorageService();
    });

    test('Save and load a value', () async {
      await storage.save('test_key', 'test_value');
      final value = await storage.load('test_key');
      expect(value, 'test_value');
    });

    test('Load non-existent key returns null', () async {
      final value = await storage.load('missing_key');
      expect(value, null);
    });

    test('Clear storage removes all values', () async {
      await storage.save('key1', 'value1');
      await storage.save('key2', 'value2');
      
      await storage.clear();
      
      expect(await storage.load('key1'), null);
      expect(await storage.load('key2'), null);
    });
  });
}
