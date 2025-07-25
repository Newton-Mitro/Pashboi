import 'package:pashboi/core/entities/entity.dart';

class LoanPolicyEntity extends Entity<String> {
  final String title;
  final String slug;
  final int order;
  final String shortDescription;
  final String longDescription;
  final String attachmentUrl;
  final String attachmentPath;
  final String attachmentName;
  final String attachmentMimeType;
  final String publishStatus;
  final String categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoanPolicyEntity({
    required this.title,
    required this.slug,
    required this.order,
    required this.shortDescription,
    required this.longDescription,
    required this.attachmentUrl,
    required this.attachmentPath,
    required this.attachmentName,
    required this.attachmentMimeType,
    required this.publishStatus,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required super.id,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    order,
    shortDescription,
    longDescription,
    attachmentUrl,
    attachmentPath,
    attachmentName,
    attachmentMimeType,
    publishStatus,
    categoryId,
    createdAt,
    updatedAt,
  ];
}
