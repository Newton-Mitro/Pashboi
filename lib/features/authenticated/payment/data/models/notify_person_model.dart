import 'package:pashboi/features/authenticated/payment/domain/entities/notify_person_entity.dart';

class NotifyPersonModel extends NotifyPersonEntity {
  NotifyPersonModel({
    required super.id,
    required super.fullName,
    required super.mobileNumber,
  });

  factory NotifyPersonModel.fromJson(Map<String, dynamic> json) {
    return NotifyPersonModel(
      id: json['PersonId'] ?? 0,
      fullName: json['FullName'] ?? '',
      mobileNumber: json['MobileNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'PersonId': id, 'FullName': fullName, 'MobileNumber': mobileNumber};
  }
}
