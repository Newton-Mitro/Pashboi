import 'package:pashboi/features/user/data/models/follow_un_follow_model.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

abstract class UsersDataSource {
  Future<FollowUnFollowModel> followUser(int followingUserId);

  Future<FollowUnFollowModel> unFollowUser(int followingUserId);

  Future<List<UserModel>> getFollowingUsers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> getFollowers(
    int targetUserId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> searchUsers(
    int userId,
    String searchText,
    int startRecord,
    int pageSize,
  );

  Future<List<UserModel>> getSuggestedUsers(
    int userId,
    int startRecord,
    int pageSize,
  );
}
