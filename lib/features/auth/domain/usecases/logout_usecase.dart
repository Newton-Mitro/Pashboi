import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class LogoutParams {}

class LogoutUsecase extends UseCase<void, LogoutParams> {
  final AuthRepository authRepository;

  LogoutUsecase({required this.authRepository});

  @override
  ResultFuture<void> call(LogoutParams params) {
    return authRepository.logout();
  }
}
