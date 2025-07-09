import 'package:pashboi/core/entities/entity.dart';

class DevelopmentCreditsEntity extends Entity<String> {
  final String name;
  final String email;
  final String mobileNumber;
  final String facebookUrl;
  final String linkedinUrl;
  final String githubUrl;
  final String designation;
  final String slug;
  final int order;
  final String bio;
  final String attachmentUrl;
  final String attachmentPath;
  final String attachmentName;
  final String attachmentMimeType;
  final String publishStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  DevelopmentCreditsEntity({
    super.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.facebookUrl,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.designation,
    required this.slug,
    required this.order,
    required this.bio,
    required this.attachmentUrl,
    required this.attachmentPath,
    required this.attachmentName,
    required this.attachmentMimeType,
    required this.publishStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    mobileNumber,
    facebookUrl,
    linkedinUrl,
    githubUrl,
    designation,
    slug,
    order,
    bio,
    attachmentUrl,
    attachmentPath,
    attachmentName,
    attachmentMimeType,
    publishStatus,
    createdAt,
    updatedAt,
  ];
}
