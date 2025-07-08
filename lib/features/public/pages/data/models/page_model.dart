import 'package:pashboi/features/public/pages/domain/enities/page_entity.dart';

class PageModel extends PageEntity {
  PageModel({
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
    required super.createdAt,
    required super.updatedAt,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      order: json['order'] ?? 0,
      shortDescription: json['short_description'] ?? '',
      longDescription: json['description'] ?? '',
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
      'title': title,
      'slug': slug,
      'order': order,
      'shortDescription': shortDescription,
      'description': longDescription,
      'attachmentUrl': attachmentUrl,
      'attachmentPath': attachmentPath,
      'attachmentName': attachmentName,
      'attachmentMimeType': attachmentMimeType,
      'publishStatus': publishStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
