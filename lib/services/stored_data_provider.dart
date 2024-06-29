import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const urlPath = "url_path";
}

class StoredDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getUrlPath() => _secureStorage.read(key: _Keys.urlPath);

  Future<void> setUrlPath(String value) {
    return _secureStorage.write(key: _Keys.urlPath, value: value);
  }
}
