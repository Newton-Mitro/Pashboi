part of 'add_family_and_friend_bloc.dart';

sealed class AddFamilyAndFriendState extends Equatable {
  const AddFamilyAndFriendState();

  @override
  List<Object> get props => [];
}

final class AddFamilyAndFriendInitial extends AddFamilyAndFriendState {}

class AddFamilyAndFriendRequestProcessing extends AddFamilyAndFriendState {}

class AddFamilyAndFriendRequestSuccess extends AddFamilyAndFriendState {
  final String message;
  const AddFamilyAndFriendRequestSuccess(this.message);
}

class AddFamilyAndFriendError extends AddFamilyAndFriendState {
  final String error;
  const AddFamilyAndFriendError(this.error);
}
