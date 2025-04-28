import 'package:pashboi/features/auth/data/models/auth_user_model.dart';

abstract class AuthDataSource {
  Future<AuthUserModel> login(String? email, String? password);
  Future<AuthUserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<void> logout();
}
