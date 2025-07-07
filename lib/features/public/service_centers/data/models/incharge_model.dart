import 'package:pashboi/features/public/service_centers/domain/entites/incharge_entity.dart';

class InChargeModel extends InChargeEntity {
  InChargeModel({
    required super.name,
    required super.designation,
    required super.contactNumber,
    required super.email,
    required super.officeLocationId,
    required super.attachmentUrl,
    required super.attachmentPath,
    required super.attachmentName,
    required super.attachmentMime,
    required super.createdAt,
    required super.updatedAt,
    required super.id,
  });

  factory InChargeModel.fromJson(Map<String, dynamic> json) {
    return InChargeModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      designation: json['designation'] ?? "",
      contactNumber: json['contact_number'] ?? "",
      email: json['email'] ?? "",
      officeLocationId: json['office_location_id'] ?? "",
      attachmentUrl: json['attachment_url'],
      attachmentPath: json['attachment_path'],
      attachmentName: json['attachment_name'],
      attachmentMime: json['attachment_mime'],
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'contact_number': contactNumber,
      'email': email,
      'office_location_id': officeLocationId,
      'attachment_url': attachmentUrl,
      'attachment_path': attachmentPath,
      'attachment_name': attachmentName,
      'attachment_mime': attachmentMime,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
