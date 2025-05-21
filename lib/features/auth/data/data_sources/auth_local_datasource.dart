import 'dart:convert';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> setAuthUser(AuthUserModel authUser);
  Future<AuthUserModel> getAuthUser();

  Future<void> clearAuthUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorage localStorage;
  AuthLocalDataSourceImpl({required this.localStorage});

  static const _userKey = 'auth_user';

  @override
  Future<void> setAuthUser(AuthUserModel authUser) async {
    final userJson = jsonEncode(authUser.toJson());
    await localStorage.saveString(_userKey, userJson);
  }

  @override
  Future<AuthUserModel> getAuthUser() async {
    final userJsonString = await localStorage.getString(_userKey);
    if (userJsonString.isEmpty) {
      throw Exception('User not found in local storage');
    }

    final Map<String, dynamic> decoded = jsonDecode(userJsonString);
    return AuthUserModel.fromJson(decoded);
  }

  @override
  Future<void> clearAuthUser() async {
    await localStorage.remove(_userKey);
  }
}
