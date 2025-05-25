import 'package:pashboi/core/entities/entity.dart';

class NomineeEntity extends Entity<int> {
  final String name;
  final String relation;
  final String phone;
  final String nationalId;
  final double percentage;
  final DateTime? dateOfBirth;
  final String? address;

  NomineeEntity({
    super.id,
    required this.name,
    required this.relation,
    required this.phone,
    required this.nationalId,
    required this.percentage,
    this.dateOfBirth,
    this.address,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    relation,
    phone,
    nationalId,
    percentage,
    dateOfBirth,
    address,
  ];
}
