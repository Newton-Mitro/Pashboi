import 'package:pashboi/core/entities/entity.dart';

class FamilyAndFriendEntity extends Entity<int> {
  final String relationName;
  final int userPersonId;
  final int familyMemberId;
  final String familyMemberName;
  final int familyMemberAge;
  final String familyMemberGender;
  final String requestStatus;

  FamilyAndFriendEntity({
    super.id,
    required this.relationName,
    required this.userPersonId,
    required this.familyMemberId,
    required this.familyMemberName,
    required this.familyMemberAge,
    required this.familyMemberGender,
    required this.requestStatus,
  });

  @override
  List<Object?> get props => [
    id,
    relationName,
    userPersonId,
    familyMemberId,
    familyMemberName,
    familyMemberAge,
    familyMemberGender,
    requestStatus,
  ];
}
