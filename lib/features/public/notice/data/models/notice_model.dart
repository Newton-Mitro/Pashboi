import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';

class NoticeModel extends NoticeEntity {
  NoticeModel({
    required super.id,
    required super.title,
    required super.slug,
    required super.order,
    required super.shortDescription,
    required super.description,
    required super.attachmentUrl,
    required super.attachmentPath,
    required super.attachmentName,
    required super.attachmentMime,
    required super.publishStatus,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] ?? "",
      title: json['title'] ?? "",
      slug: json['slug'] ?? "",
      order: json['order'] ?? 0,
      shortDescription: json['short_description'] ?? "",
      description: json['description'] ?? "",
      attachmentUrl: json['attachment_url'] ?? "",
      attachmentPath: json['attachment_path'] ?? "",
      attachmentName: json['attachment_name'] ?? "",
      attachmentMime: json['attachment_mime'] ?? "",
      publishStatus: json['publish_status'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'order': order,
      'short_description': shortDescription,
      'description': description,
      'attachment_url': attachmentUrl,
      'attachment_path': attachmentPath,
      'attachment_name': attachmentName,
      'attachment_mime': attachmentMime,
      'publish_status': publishStatus,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
