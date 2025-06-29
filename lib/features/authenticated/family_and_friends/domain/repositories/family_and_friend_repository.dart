import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

abstract class FamilyAndFriendRepository {
  ResultFuture<List<FamilyAndFriendEntity>> getFamilyAndFriends(
    GetFamilyAndFriendsProps props,
  );
  ResultFuture<String> addFamilyAndFriend(AddFamilyAndFriendProps params);
}
