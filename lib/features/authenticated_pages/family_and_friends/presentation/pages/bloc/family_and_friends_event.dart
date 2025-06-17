part of 'family_and_friends_bloc.dart';

sealed class FamilyAndFriendsEvent extends Equatable {
  const FamilyAndFriendsEvent();

  @override
  List<Object> get props => [];
}

class LoadFamilyAndFriends extends FamilyAndFriendsEvent {}

class AddFamilyAndFriend extends FamilyAndFriendsEvent {
  final FamilyAndFriendEntity familyAndFriend;
  const AddFamilyAndFriend(this.familyAndFriend);
}
