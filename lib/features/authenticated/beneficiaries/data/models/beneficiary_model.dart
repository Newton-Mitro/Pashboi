import 'package:pashboi/features/authenticated/beneficiaries/domain/entities/beneficiary_entity.dart';

class BeneficiaryModel extends BeneficiaryEntity {
  BeneficiaryModel({
    super.id,
    required super.name,
    required super.accountNumber,
  });

  factory BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    return BeneficiaryModel(
      id: json['Id'] ?? 0,
      name: json['PersonName'],
      accountNumber: json['AccountNo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Id': id, 'PersonName': name, 'AccountNo': accountNumber};
  }
}
