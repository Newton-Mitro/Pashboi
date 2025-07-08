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
      id: json['id'] as int,
      durationName: json['durationName'] as String,
      durationInMonths: json['durationInMonths'] as int,
      interestRate: (json['interestRate'] as num).toDouble(),
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
