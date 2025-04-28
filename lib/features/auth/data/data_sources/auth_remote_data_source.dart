import 'dart:io';

import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/index.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_data_source.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';

class AuthRemoteDataSourceImpl implements AuthDataSource {
  final ApiService apiService;
  final LocalStorage localStorage;

  AuthRemoteDataSourceImpl({
    required this.apiService,
    required this.localStorage,
  });

  @override
  Future<AuthUserModel> login(String? email, String? password) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data!['data'];
        AuthUserModel res = AuthUserModel.fromJson(data);

        await localStorage.saveString(
          Constants.accessTokenKey,
          res.accessToken,
        );
        await localStorage.saveString(
          Constants.refreshTokenKey,
          res.refreshToken,
        );
        await localStorage.saveString(
          Constants.authUserKey,
          res.user.toString(),
        );

        return res;
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthUserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
        },
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data!['message'];
        return data;
      } else {
        throw Exception('Failed to register');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    await apiService.get('/auth/logout');
  }
}
