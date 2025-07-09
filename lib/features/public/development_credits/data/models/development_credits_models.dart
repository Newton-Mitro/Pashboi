import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';

class DevelopmentCreditsModel extends DevelopmentCreditsEntity {
  DevelopmentCreditsModel({
    super.id,
    required super.name,
    required super.email,
    required super.mobileNumber,
    required super.facebookUrl,
    required super.linkedinUrl,
    required super.githubUrl,
    required super.designation,
    required super.slug,
    required super.order,
    required super.bio,
    required super.attachmentUrl,
    required super.attachmentPath,
    required super.attachmentName,
    required super.attachmentMimeType,
    required super.publishStatus,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DevelopmentCreditsModel.fromJson(Map<String, dynamic> json) {
    return DevelopmentCreditsModel(
      id: json['id'] as String?,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      facebookUrl: json['fb_url'] ?? '',
      linkedinUrl: json['linkedin_url'] ?? '',
      githubUrl: json['github_url'] ?? '',
      designation: json['designation'] ?? '',
      slug: json['slug'] ?? '',
      order: json['order'] ?? 0,
      bio: json['bio'] ?? '',
      attachmentUrl: json['attachment_url'] ?? '',
      attachmentPath: json['attachment_path'] ?? '',
      attachmentName: json['attachment_name'] ?? '',
      attachmentMimeType: json['attachment_mime'] ?? '',
      publishStatus: json['publish_status'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'mobile_number': mobileNumber,
      'fb_url': facebookUrl,
      'linkedin_url': linkedinUrl,
      'github_url': githubUrl,
      'designation': designation,
      'slug': slug,
      'order': order,
      'bio': bio,
      'attachment_url': attachmentUrl,
      'attachment_path': attachmentPath,
      'attachment_name': attachmentName,
      'attachment_mime': attachmentMimeType,
      'publish_status': publishStatus,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
