part of 'add_family_and_friend_bloc.dart';

sealed class AddFamilyAndFriendState extends Equatable {
  const AddFamilyAndFriendState();

  @override
  List<Object> get props => [];
}

final class AddFamilyAndFriendInitial extends AddFamilyAndFriendState {}

class FamilyAndFriendsRequestProcessing extends AddFamilyAndFriendState {}

class FamilyAndFriendsRequestSuccess extends AddFamilyAndFriendState {
  final String message;
  const FamilyAndFriendsRequestSuccess(this.message);
}

class FamilyAndFriendsError extends AddFamilyAndFriendState {
  final String error;
  const FamilyAndFriendsError(this.error);
}
