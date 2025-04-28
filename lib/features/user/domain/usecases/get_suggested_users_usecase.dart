import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/domain/repositories/user_profile_repository.dart';

final class GetSuggestedUsersParams {
  final int userId;
  final int startRecord;
  final int pageSize;

  GetSuggestedUsersParams({
    required this.userId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetSuggestedUsersUseCase
    extends UseCase<DataState<List<UserEntity>>, GetSuggestedUsersParams> {
  final UserRepository userRepository;

  GetSuggestedUsersUseCase({required this.userRepository});

  @override
  Future<DataState<List<UserEntity>>> call({GetSuggestedUsersParams? params}) {
    return userRepository.getSuggestedUsers(
      params?.userId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
