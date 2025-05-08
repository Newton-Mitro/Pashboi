import 'dart:convert';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> setAuthToken(String token);
  Future<String> getAuthToken();

  Future<void> setUser(UserModel user);
  Future<UserModel> getUser();

  Future<void> clearAuthInfo();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;
  AuthLocalDataSourceImpl({required this.localStorage});

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  @override
  Future<void> setAuthToken(String token) async {
    await localStorage.saveString(_tokenKey, token);
  }

  @override
  Future<String> getAuthToken() async {
    final token = await localStorage.getString(_tokenKey);
    if (token.isEmpty) {
      throw Exception('Auth token not found in local storage');
    }
    return token;
  }

  @override
  Future<void> setUser(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await localStorage.saveString(_userKey, userJson);
  }

  @override
  Future<UserModel> getUser() async {
    final userJsonString = await localStorage.getString(_userKey);
    if (userJsonString.isEmpty) {
      throw Exception('User not found in local storage');
    }

    final Map<String, dynamic> decoded = jsonDecode(userJsonString);
    return UserModel.fromJson(decoded);
  }

  @override
  Future<void> clearAuthInfo() async {
    await localStorage.remove(_tokenKey);
    await localStorage.remove(_userKey);
  }
}
