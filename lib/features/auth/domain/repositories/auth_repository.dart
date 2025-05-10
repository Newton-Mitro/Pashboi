import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  );
  ResultFuture<UserEntity> login(String email, String password);
  ResultVoid logout();
  ResultFuture<UserEntity> getAuthUser();
}
