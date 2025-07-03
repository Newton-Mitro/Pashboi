import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';

class ServicePolicyModel extends ServicePolicyEntity {
  ServicePolicyModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.order,
    required super.shortDescription,
    required super.longDescription,
    required super.attachmentUrl,
    required super.attachmentPath,
    required super.attachmentName,
    required super.attachmentMimeType,
    required super.publishStatus,
    required super.categoryId,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ServicePolicyModel.fromJson(Map<String, dynamic> json) {
    return ServicePolicyModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      order: json['order'] ?? "",
      shortDescription: json['short_description'] ?? "",
      longDescription: json['long_description'] ?? "",
      attachmentUrl: json['attachment_url'] ?? "",
      attachmentPath: json['attachment_path'] ?? "",
      attachmentName: json['attachment_name'] ?? "",
      attachmentMimeType: json['attachment_mime'] ?? "",
      publishStatus: json['publish_status'] ?? "",
      categoryId: json['product_categories_id'] ?? "",
      createdAt: DateTime.parse(json['created_at'] ?? ""),
      updatedAt: DateTime.parse(json['updated_at'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'order': order,
      'short_description': shortDescription,
      'long_description': longDescription,
      'attachment_url': attachmentUrl,
      'attachment_path': attachmentPath,
      'attachment_name': attachmentName,
      'attachment_mime': attachmentMimeType,
      'publish_status': publishStatus,
      'product_categories_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
