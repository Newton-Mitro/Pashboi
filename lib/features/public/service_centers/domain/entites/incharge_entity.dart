import 'package:pashboi/core/entities/entity.dart';

class InChargeEntity extends Entity<String> {
  final String name;
  final String designation;
  final String contactNumber;
  final String email;
  final String officeLocationId;
  final String? attachmentUrl;
  final String? attachmentPath;
  final String? attachmentName;
  final String? attachmentMime;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  InChargeEntity({
    required this.name,
    required this.designation,
    required this.contactNumber,
    required this.email,
    required this.officeLocationId,
    required this.attachmentUrl,
    required this.attachmentPath,
    required this.attachmentName,
    required this.attachmentMime,
    required this.createdAt,
    required this.updatedAt,
    required super.id,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    designation,
    contactNumber,
    email,
    officeLocationId,
    attachmentUrl,
    attachmentPath,
    attachmentName,
    attachmentMime,
    createdAt,
    updatedAt,
  ];
}
