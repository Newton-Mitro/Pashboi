import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/relationship_entity.dart';

class RelationshipModel extends RelationshipEntity {
  RelationshipModel({
    super.id,
    required super.name,
    required super.gender,
    required super.code,
  });

  factory RelationshipModel.fromJson(Map<String, dynamic> json) {
    return RelationshipModel(
      id: json['Id'] ?? 0,
      name: json['RelationName'] ?? '',
      gender: json['Gender'] ?? '',
      code: json['RelationTypeCode'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'gender': gender, 'code': code};
  }
}
