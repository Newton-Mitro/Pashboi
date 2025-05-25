import 'package:pashboi/features/authenticated_pages/savings/domain/entities/nominee_entity.dart';

class NomineeModel extends NomineeEntity {
  NomineeModel({
    required super.id,
    required super.name,
    required super.relation,
    required super.phone,
    required super.nationalId,
    required super.percentage,
    super.dateOfBirth,
    super.address,
  });

  factory NomineeModel.fromJson(Map<String, dynamic> json) {
    return NomineeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      relation: json['relation'] ?? '',
      phone: json['phone'] ?? '',
      nationalId: json['national_id'] ?? '',
      percentage: (json['percentage'] ?? 0).toDouble(),
      dateOfBirth:
          json['date_of_birth'] != null
              ? DateTime.tryParse(json['date_of_birth'])
              : null,
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relation': relation,
      'phone': phone,
      'national_id': nationalId,
      'percentage': percentage,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'address': address,
    };
  }
}
