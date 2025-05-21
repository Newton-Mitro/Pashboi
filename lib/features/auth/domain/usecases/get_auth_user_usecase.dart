import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

class GetAuthUserUseCase extends UseCase<AuthUserEntity, NoParams> {
  final AuthRepository authRepository;

  GetAuthUserUseCase({required this.authRepository});

  @override
  ResultFuture<AuthUserEntity> call(NoParams? params) async {
    final loggedInUser = await authRepository.getAuthUser();
    return loggedInUser;
  }
}
