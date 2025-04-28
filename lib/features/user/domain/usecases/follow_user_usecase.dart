import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:pashboi/features/user/domain/repositories/user_profile_repository.dart';

final class FollowUserParams {
  final int followingUserId;

  FollowUserParams({required this.followingUserId});
}

class FollowUserUseCase
    extends UseCase<DataState<FollowUnFollowEntity>, FollowUserParams> {
  final UserRepository userRepository;

  FollowUserUseCase({required this.userRepository});

  @override
  Future<DataState<FollowUnFollowEntity>> call({
    FollowUserParams? params,
  }) async {
    final followingCount = userRepository.followUser(
      params?.followingUserId ?? 0,
    );
    return followingCount;
  }
}
