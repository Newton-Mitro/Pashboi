import 'dart:io';

import 'package:pashboi/core/services/network/api_service.dart';
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

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel> login(String? email, String? password) async {
    try {
      final response = await apiService.post(
        'LoginAPI/Post_V2',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['data'][0];
        if (data == null) throw Exception('Invalid response format');

        final token = response.headers['authorization']?.first;

        final userModel = UserModel.fromJson(data);
        userModel.copyWith(accessToken: token);

        return userModel;
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
        'Auth_V1/UserRegister',
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
    } catch (e) {
      rethrow;
    }
  }
}
