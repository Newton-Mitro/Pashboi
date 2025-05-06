import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class GetAuthUserParams {}

class GetAuthUserUseCase extends UseCase<UserEntity, GetAuthUserParams> {
  final AuthRepository authRepository;

  GetAuthUserUseCase({required this.authRepository});

  @override
  ResultFuture<UserEntity> call({GetAuthUserParams? params}) async {
    final loggedInUser = await authRepository.getAuthUser();
    return loggedInUser;
  }
}
