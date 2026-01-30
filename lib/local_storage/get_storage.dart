import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final GetStorage _box = GetStorage();

  static const String _accessToken = 'access_token';

  /// Save Token
  static void saveToken({required String accessToken}) {
    _box.write(_accessToken, accessToken);
  }

  /// Get Token
  static String? get getAccessToken {
    return _box.read(_accessToken);
  }

  /// Delete Token
  static void clear() {
    _box.remove(_accessToken);
  }
}
