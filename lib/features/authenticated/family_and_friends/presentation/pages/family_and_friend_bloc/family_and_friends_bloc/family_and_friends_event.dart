part of 'family_and_friends_bloc.dart';

sealed class FamilyAndFriendsEvent extends Equatable {
  const FamilyAndFriendsEvent();

  @override
  List<Object> get props => [];
}

class FetchFamilyAndFriends extends FamilyAndFriendsEvent {}

class AddFamilyAndFriend extends FamilyAndFriendsEvent {
  final int childPersonId;
  final String relationTypeCode;
  final String accountNumber;
  final String memberName;
  final String gender;
  final String relationship;

  const AddFamilyAndFriend({
    required this.childPersonId,
    required this.relationTypeCode,
    required this.accountNumber,
    required this.memberName,
    required this.gender,
    required this.relationship,
  });
}
