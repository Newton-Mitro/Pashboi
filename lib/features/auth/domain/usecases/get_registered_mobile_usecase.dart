import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

class GetRegisteredMobileUseCase extends UseCase<String, NoParams> {
  final AuthRepository authRepository;

  GetRegisteredMobileUseCase({required this.authRepository});

  @override
  ResultFuture<String> call(NoParams? params) async {
    final mobile = await authRepository.getRegisteredMobile();
    return mobile;
  }
}
