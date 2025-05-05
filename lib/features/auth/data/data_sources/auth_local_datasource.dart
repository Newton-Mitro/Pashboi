import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveAuthInfo(String token);
  Future<String?> getAuthInfo();
  Future<void> clearAuthInfo();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;
  AuthLocalDataSourceImpl(this.prefs);

  static const _tokenKey = 'auth_info';

  @override
  Future<void> saveAuthInfo(String token) => prefs.setString(_tokenKey, token);

  @override
  Future<String?> getAuthInfo() => Future.value(prefs.getString(_tokenKey));

  @override
  Future<void> clearAuthInfo() => prefs.remove(_tokenKey);
}
