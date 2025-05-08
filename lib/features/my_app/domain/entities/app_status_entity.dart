import 'package:pashboi/core/entities/entity.dart';

class AppStatusEntity extends Entity {
  final bool isUpdated;
  final String updateMessage;
  final String version;
  final DateTime versionDate;
  final bool isMaintenance;
  final DateTime maintenanceDate;
  final String maintenanceMessage;

  AppStatusEntity({
    super.id,
    required this.isUpdated,
    required this.updateMessage,
    required this.version,
    required this.versionDate,
    required this.isMaintenance,
    required this.maintenanceDate,
    required this.maintenanceMessage,
  });

  @override
  List<Object?> get props => [
    id,
    isUpdated,
    updateMessage,
    version,
    versionDate,
    isMaintenance,
    maintenanceDate,
    maintenanceMessage,
  ];

  AppStatusEntity copyWith({
    String? id,
    bool? isUpdated,
    String? updateMessage,
    String? version,
    DateTime? versionDate,
    bool? isMaintenance,
    DateTime? maintenanceDate,
    String? maintenanceMessage,
  }) {
    return AppStatusEntity(
      id: id ?? this.id,
      isUpdated: isUpdated ?? this.isUpdated,
      updateMessage: updateMessage ?? this.updateMessage,
      version: version ?? this.version,
      versionDate: versionDate ?? this.versionDate,
      isMaintenance: isMaintenance ?? this.isMaintenance,
      maintenanceDate: maintenanceDate ?? this.maintenanceDate,
      maintenanceMessage: maintenanceMessage ?? this.maintenanceMessage,
    );
  }
}
