import 'package:dio/dio.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:pashboi/features/my_app/presentation/pages/my_app.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;

  AuthInterceptor({required this.dio, required this.authLocalDataSource});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final authUser = await authLocalDataSource.getAuthUser();
      final accessToken = authUser.accessToken;

      options.headers['Accept'] = 'application/json';
      options.headers['Content-Type'] = 'application/json';

      if (accessToken.isNotEmpty) {
        options.headers['Token'] = accessToken;
      }

      return handler.next(options);
    } catch (e) {
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final dataString = response.data?['Message'];

    if (dataString is String &&
        dataString == 'Authorization has been denied for this request.') {
      authLocalDataSource.clearAuthUser().then((_) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      });
    }

    return handler.next(response);
  }
}
