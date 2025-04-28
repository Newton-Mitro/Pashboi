import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/user/domain/entities/follow_unfollow_entity.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<DataState<FollowUnFollowEntity>> followUser(int followingUserId);

  Future<DataState<FollowUnFollowEntity>> unFollowUser(int followingUserId);

  Future<DataState<List<UserEntity>>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );

  Future<DataState<List<UserEntity>>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );

  Future<DataState<List<UserEntity>>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<DataState<List<UserEntity>>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<DataState<List<UserEntity>>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  );
}
