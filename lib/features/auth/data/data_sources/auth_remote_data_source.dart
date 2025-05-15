import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<String> register(
    String email,
    String password,
    String confirmPassword,
    String requestFrom,
  );
  Future<void> logout();

  Future<String> verifyMobileNumber(
    String mobileNumber,
    bool isRegistered,
    String requestFrom,
  );

  Future<String> verifyOtp(
    String otpRegId,
    String otpValue,
    String mobileNumber,
    String requestFrom,
  );
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiService.post(
        ApiUrls.login,
        data: {"UserName": email, "Password": password, "RequestFrom": "Web"},
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final token = response.headers['token']?.first;

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final userModel = UserModel.fromJson({
          ...jsonResponse[0],
          "accessToken": token,
        });

        return userModel;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register(
    String email,
    String password,
    String confirmPassword,
    String requestFrom,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.register,
        data: {
          'UserName': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'RequestFrom': requestFrom,
        },
      );

      if (response.statusCode == HttpStatus.created) {
        final data = response.data?['Data'];
        if (data == null) throw Exception('Invalid response format');

        return data;
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
      // await apiService.get('/auth/logout');
    } catch (e) {
      // rethrow;
    }
  }

  @override
  Future<String> verifyMobileNumber(
    String mobileNumber,
    bool isRegistered,
    String requestFrom,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.verifyMobileNumber,
        data: {
          'MobileNo': mobileNumber,
          'IsRegistered': isRegistered,
          'RequestFrom': requestFrom,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['Data'];
        if (data == null) throw Exception('Invalid response format');

        return data;
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
  Future<String> verifyOtp(
    String otpRegId,
    String otpValue,
    String mobileNumber,
    String requestFrom,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.verifyOTP,
        data: {
          'OTPRegId': otpRegId,
          'OTPValue': otpValue,
          'MobileNumber': mobileNumber,
          'RequestFrom': requestFrom,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['Data'];
        if (data == null) throw Exception('Invalid response format');

        return data;
      } else {
        throw Exception(
          'Registration failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
