import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/domain/repositories/user_profile_repository.dart';

final class GetFollowersParams {
  final int targetUserId;
  final int startRecord;
  final int pageSize;

  GetFollowersParams({
    required this.targetUserId,
    required this.startRecord,
    required this.pageSize,
  });
}

class GetFollowersUseCase
    extends UseCase<DataState<List<UserEntity>>, GetFollowersParams> {
  final UserRepository userRepository;

  GetFollowersUseCase({required this.userRepository});

  @override
  Future<DataState<List<UserEntity>>> call({GetFollowersParams? params}) {
    return userRepository.getFollowers(
      params?.targetUserId ?? 0,
      params?.startRecord ?? 0,
      params?.pageSize ?? 10,
    );
  }
}
