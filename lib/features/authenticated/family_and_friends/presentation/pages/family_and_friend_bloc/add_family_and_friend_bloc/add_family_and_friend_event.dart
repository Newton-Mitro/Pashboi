part of 'add_family_and_friend_bloc.dart';

class AddFamilyAndFriendEvent extends Equatable {
  final int childPersonId;
  final String relationTypeCode;

  const AddFamilyAndFriendEvent({
    required this.childPersonId,
    required this.relationTypeCode,
  });

  @override
  List<Object> get props => [childPersonId, relationTypeCode];
}
