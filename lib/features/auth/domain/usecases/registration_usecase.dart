import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class RegistrationParams {
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationParams({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

class RegistrationUseCase extends UseCase<String, RegistrationParams> {
  final AuthRepository authRepository;

  RegistrationUseCase({required this.authRepository});

  @override
  ResultFuture<String> call(RegistrationParams params) async {
    final authUser = await authRepository.register(
      params.email,
      params.password,
      params.confirmPassword,
    );

    return authUser;
  }
}
