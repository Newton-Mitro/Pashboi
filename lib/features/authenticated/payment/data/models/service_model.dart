import 'package:pashboi/features/authenticated/payment/data/models/notify_person_model.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/service_entity.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    required super.id,
    required super.serviceCode,
    required super.serviceName,
    required super.serviceAccount,
    required super.serviceIcon,
    required super.serviceType,
    required super.notifyPersons,
    required super.remarks,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['ServiceId'] ?? 0,
      serviceCode: json['ServiceCode'] ?? '',
      serviceName: json['ServiceName'] ?? '',
      serviceAccount: json['ServiceAccount'] ?? '',
      serviceIcon: json['ServiceIcon'] ?? '',
      serviceType: json['ServiceType'] ?? '',
      notifyPersons:
          (json['NotifyPerson'] as List<dynamic>? ?? [])
              .map((e) => NotifyPersonModel.fromJson(e))
              .toList(),
      remarks: json['Remarks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ServiceId': id,
      'ServiceCode': serviceCode,
      'ServiceName': serviceName,
      'ServiceAccount': serviceAccount,
      'ServiceIcon': serviceIcon,
      'ServiceType': serviceType,
      'NotifyPerson':
          notifyPersons.map((e) => (e as NotifyPersonModel).toJson()).toList(),
      'Remarks': remarks,
    };
  }
}
