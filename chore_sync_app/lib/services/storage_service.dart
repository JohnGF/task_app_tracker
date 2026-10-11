class StorageService {
  final Map<String, dynamic> _storage = {};

  Future<void> save(String key, dynamic value) async {
    _storage[key] = value;
  }

  Future<dynamic> load(String key) async {
    return _storage[key];
  }

  Future<void> clear() async {
    _storage.clear();
  }
}
