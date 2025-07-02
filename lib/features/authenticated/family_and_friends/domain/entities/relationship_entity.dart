import 'package:pashboi/core/entities/entity.dart';

class RelationshipEntity extends Entity<int> {
  final String name;
  final String gender;
  final String code;

  RelationshipEntity({
    super.id,
    required this.name,
    required this.gender,
    required this.code,
  });

  @override
  List<Object?> get props => [id, name, gender, code];
}
