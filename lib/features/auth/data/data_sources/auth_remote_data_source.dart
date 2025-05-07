import 'dart:io';

import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String? email, String? password);

  Future<UserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;
  final LocalStorage localStorage;

  AuthRemoteDataSourceImpl({
    required this.apiService,
    required this.localStorage,
  });

  @override
  Future<UserModel> login(String? email, String? password) async {
    try {
      final response = await apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['data'];
        if (data == null) throw Exception('Invalid response format');

        final token = response.headers['authorization']?.first;
        // Or use: response.data?['token'] if your token comes in body

        if (token != null) {
          await localStorage.saveString(StorageKey.keyAccessToken, token);
        }

        return UserModel.fromJson(data);
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> register(
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
        final data = response.data?['data'];
        if (data == null) throw Exception('Invalid response format');

        return UserModel.fromJson(data);
      } else {
        throw Exception(
          'Registration failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiService.get('/auth/logout');
      await localStorage.remove(StorageKey.keyAccessToken);
    } catch (e) {
      rethrow;
    }
  }
}
