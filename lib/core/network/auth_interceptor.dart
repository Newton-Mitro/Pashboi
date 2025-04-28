import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pashboi/core/constants/api_config.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/auth_module.dart';
import 'package:pashboi/my_app.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final LocalStorage localStorage;

  late String? accessToken;
  late String? refreshToken;

  AuthInterceptor({required this.dio, required this.localStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    accessToken = await localStorage.getString(Constants.accessTokenKey);

    options.headers['Accept'] = 'application/json';

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      if (JwtDecoder.isExpired(accessToken!)) {
        final newRefreshToken = await _handleTokenRefresh();
        if (newRefreshToken != null) {
          options.headers["Authorization"] = "Bearer $newRefreshToken";
        }
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final newToken = await _handleTokenRefresh();
      if (newToken != null) {
        err.requestOptions.headers["Authorization"] = "Bearer $newToken";

        try {
          final retryResponse = await dio.fetch(err.requestOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }

  Future<String?> _handleTokenRefresh() async {
    try {
      refreshToken = await localStorage.getString(Constants.refreshTokenKey);
      if (refreshToken == null || JwtDecoder.isExpired(refreshToken!)) {
        await _logout();
        return null;
      }

      final response = await dio.get(
        '${ApiConfig.baseUrl}/auth/refresh',
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['data'];
        if (data != null) {
          var res = AuthUserModel.fromJson(data);
          await localStorage.saveString(
            Constants.accessTokenKey,
            res.accessToken,
          );
          await localStorage.saveString(
            Constants.refreshTokenKey,
            res.refreshToken,
          );
          return res.accessToken;
        }
      }

      await _logout();
      return null;
    } catch (e) {
      await _logout();
      return null;
    }
  }

  Future<void> _logout() async {
    await localStorage.remove(Constants.accessTokenKey);
    await localStorage.remove(Constants.refreshTokenKey);
    await localStorage.remove(Constants.authUserKey);
    // Dispatch LogoutEvent using context (inside a widget tree)
    final context = navigatorKey.currentContext;
    if (context != null) {
      context.read<AuthBloc>().add(LogoutEvent());
    }
  }
}
