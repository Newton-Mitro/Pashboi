import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/family_and_friend_entity.dart';

class FamilyAndFriendModel extends FamilyAndFriendEntity {
  FamilyAndFriendModel({
    required int super.id,
    required super.relationName,
    required super.userPersonId,
    required super.familyMemberId,
    required super.familyMemberName,
    required super.familyMemberAge,
    required super.familyMemberGender,
    required super.requestStatus,
  });

  factory FamilyAndFriendModel.fromJson(Map<String, dynamic> json) {
    return FamilyAndFriendModel(
      id: json['RelationMapId'],
      relationName: json['RelationName'],
      userPersonId: json['PersonId'],
      familyMemberId: json['ParentPersonId'],
      familyMemberName: json['FullName'],
      familyMemberAge: json['Age'],
      familyMemberGender: json['Gender'],
      requestStatus: json['RequestStatus'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'relationName': relationName,
      'userPersonId': userPersonId,
      'familyMemberId': familyMemberId,
      'familyMemberName': familyMemberName,
      'familyMemberAge': familyMemberAge,
      'familyMemberGender': familyMemberGender,
      'requestStatus': requestStatus,
    };
  }

  FamilyAndFriendEntity toEntity() => this;
}
