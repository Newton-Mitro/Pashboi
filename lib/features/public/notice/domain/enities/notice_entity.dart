import 'package:dartz/dartz.dart';
import 'package:pashboi/core/entities/entity.dart';

class NoticeEntity extends Entity<String> {
  final String title;
  final String slug;
  final int order;
  final String shortDescription;
  final String description;
  final String attachmentUrl;
  final String attachmentPath;
  final String attachmentName;
  final String attachmentMime;
  final String publishStatus;
  final String createdAt;
  final String updatedAt;

  NoticeEntity({
    required super.id,
    required this.title,
    required this.slug,
    required this.order,
    required this.shortDescription,
    required this.description,
    required this.attachmentUrl,
    required this.attachmentPath,
    required this.attachmentName,
    required this.attachmentMime,
    required this.publishStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    order,
    shortDescription,
    description,
    attachmentUrl,
    attachmentPath,
    attachmentName,
    attachmentMime,
    publishStatus,
    createdAt,
    updatedAt,
  ];
}
