import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';

class TenureAmountModel extends TenureAmountEntity {
  TenureAmountModel({
    required super.id,
    required super.durationInMonths,
    required super.depositAmount,
  });

  factory TenureAmountModel.fromJson(Map<String, dynamic> json) {
    return TenureAmountModel(
      id: json['id'] as int,
      durationInMonths: json['durationInMonths'] as int,
      depositAmount: (json['depositAmount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'durationInMonths': durationInMonths,
      'depositAmount': depositAmount,
    };
  }
}
