part of 'family_and_friends_bloc.dart';

sealed class FamilyAndFriendsState extends Equatable {
  const FamilyAndFriendsState();

  @override
  List<Object> get props => [];
}

final class FamilyAndFriendsInitial extends FamilyAndFriendsState {}

class FamilyAndFriendsLoading extends FamilyAndFriendsState {}

class FamilyAndFriendsLoadingSuccess extends FamilyAndFriendsState {
  final List<FamilyAndFriendEntity> familyAndFriends;
  const FamilyAndFriendsLoadingSuccess(this.familyAndFriends);
}

class FamilyAndFriendsError extends FamilyAndFriendsState {
  final String error;
  const FamilyAndFriendsError(this.error);
}
