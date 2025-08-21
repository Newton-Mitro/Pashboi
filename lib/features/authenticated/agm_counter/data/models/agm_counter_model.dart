import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';

class AGMCounterModel extends AGMCounterEntity {
  AGMCounterModel({
    required super.id,
    required super.counterNo,
    required super.locationName,
    required super.accountNo,
    required super.fullName,
    required super.slNo,
  });

  factory AGMCounterModel.fromJson(Map<String, dynamic> json) {
    return AGMCounterModel(
      id: json['SlNo'] ?? 0,
      counterNo: json['CounterNo'] ?? '',
      locationName: json['LocationName'] ?? '',
      accountNo: json['AccountNo'] ?? '',
      fullName: json['FullName'] ?? '',
      slNo: json['SlNo'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "SlNo": slNo,
      "CounterNo": counterNo,
      "LocationName": locationName,
      "AccountNo": accountNo,
      "FullName": fullName,
    };
  }
}
