import 'package:pashboi/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login(String? email, String? password);
  Future<UserModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<void> logout();
}
