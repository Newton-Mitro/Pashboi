import 'package:pashboi/features/my_app/domain/entities/app_status_entity.dart';

class AppStatusModel extends AppStatusEntity {
  AppStatusModel({
    super.id,
    required super.isUpdated,
    required super.updateMessage,
    required super.version,
    required super.versionDate,
    required super.isMaintenance,
    required super.maintenanceDate,
    required super.maintenanceMessage,
  });

  factory AppStatusModel.fromJson(Map<String, dynamic> json) {
    return AppStatusModel(
      id: json['Id']?.toString(),
      isUpdated: json['IsUpdated'],
      updateMessage: json['UpdateMessage'],
      version: json['Version'],
      versionDate: DateTime.parse(json['VersionDate']),
      isMaintenance: json['IsMaintenance'],
      maintenanceDate: DateTime.parse(json['MaintenanceDate']),
      maintenanceMessage: json['MaintenanceMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'IsUpdated': isUpdated,
      'UpdateMessage': updateMessage,
      'Version': version,
      'VersionDate': versionDate.toIso8601String(),
      'IsMaintenance': isMaintenance,
      'MaintenanceDate': maintenanceDate.toIso8601String(),
      'MaintenanceMessage': maintenanceMessage,
    };
  }
}
