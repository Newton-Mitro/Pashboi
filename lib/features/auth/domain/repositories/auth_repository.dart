import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  Future<DataState<AuthUserEntity>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<DataState<AuthUserEntity>> login(String? email, String? password);
  Future<DataState<void>> logout();
  Future<DataState<AuthUserEntity>> getAuthUser();
}
