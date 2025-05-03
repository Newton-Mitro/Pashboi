import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<DataState<UserEntity>> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  Future<DataState<UserEntity>> login(String? email, String? password);
  Future<DataState<void>> logout();
  Future<DataState<UserEntity>> getAuthUser();
}
