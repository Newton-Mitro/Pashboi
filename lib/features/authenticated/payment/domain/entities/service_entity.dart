import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/notify_person_entity.dart';

class ServiceEntity extends Entity<int> {
  final String serviceCode;
  final String serviceName;
  final String serviceAccount;
  final String serviceIcon;
  final String serviceType;
  final List<NotifyPersonEntity> notifyPersons;
  final String remarks;

  ServiceEntity({
    required super.id,
    required this.serviceCode,
    required this.serviceName,
    required this.serviceAccount,
    required this.serviceIcon,
    required this.serviceType,
    required this.notifyPersons,
    required this.remarks,
  });

  ServiceEntity copyWith({
    int? id,
    String? serviceCode,
    String? serviceName,
    String? serviceAccount,
    String? serviceIcon,
    String? serviceType,
    List<NotifyPersonEntity>? notifyPersons,
    String? remarks,
  }) {
    return ServiceEntity(
      id: id ?? this.id,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceName: serviceName ?? this.serviceName,
      serviceAccount: serviceAccount ?? this.serviceAccount,
      serviceIcon: serviceIcon ?? this.serviceIcon,
      serviceType: serviceType ?? this.serviceType,
      notifyPersons: notifyPersons ?? this.notifyPersons,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  List<Object?> get props => [
    id,
    serviceCode,
    serviceName,
    serviceAccount,
    serviceIcon,
    serviceType,
    notifyPersons,
    remarks,
  ];
}
