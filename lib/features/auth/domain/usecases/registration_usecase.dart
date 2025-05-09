import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class RegistrationParams {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationParams({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class RegistrationUseCase extends UseCase<UserEntity, RegistrationParams> {
  final AuthRepository authRepository;

  RegistrationUseCase({required this.authRepository});

  @override
  ResultFuture<UserEntity> call(RegistrationParams params) async {
    final authUser = await authRepository.register(
      params.name,
      params.email,
      params.password,
      params.confirmPassword,
    );

    return authUser;
  }
}
