import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';

class TenureModel extends TenureEntity {
  TenureModel({
    required super.id,
    required super.durationName,
    required super.durationInMonths,
    required super.interestRate,
  });

  factory TenureModel.fromJson(Map<String, dynamic> json) {
    return TenureModel(
      id: json['DurationId'] ?? 0,
      durationName: json['DurationName'] ?? '',
      durationInMonths: json['DurationInMonths'] ?? 0,
      interestRate: (json['InterestRate'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'durationName': durationName,
      'durationInMonths': durationInMonths,
      'interestRate': interestRate,
    };
  }
}
