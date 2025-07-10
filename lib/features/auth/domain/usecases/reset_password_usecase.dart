import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class ResetPasswordParams {
  final String mobileNumber;
  final String password;

  ResetPasswordParams({required this.mobileNumber, required this.password});
}

class ResetPasswordUseCase extends UseCase<void, ResetPasswordParams> {
  final AuthRepository authRepository;

  ResetPasswordUseCase({required this.authRepository});

  @override
  ResultFuture<void> call(ResetPasswordParams params) async {
    return await authRepository.resetPassword(
      mobileNumber: params.mobileNumber.trim(),
      password: params.password.trim(),
    );
  }
}
