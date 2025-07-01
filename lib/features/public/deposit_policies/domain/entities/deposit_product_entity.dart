import 'package:equatable/equatable.dart';

class DepositProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? order;
  final String? short_description;
  final String? long_description;
  final String? attachment_url;
  final String? attachment_path;
  final String? attachment_name;
  final String? attachment_mime;
  final String? publish_status;
  final String? product_categories_id;
  final String? created_at;
  final String? updated_at;

  const DepositProductEntity({
    this.id,
    this.title,
    this.slug,
    this.order,
    this.short_description,
    this.long_description,
    this.attachment_url,
    this.attachment_path,
    this.attachment_name,
    this.attachment_mime,
    this.publish_status,
    this.product_categories_id,
    this.created_at,
    this.updated_at,
  });

  List<Object?> get props => [
    id,
    title,
    slug,
    order,
    short_description,
    long_description,
    attachment_url,
    attachment_path,
    attachment_name,
    attachment_mime,
    publish_status,
    product_categories_id,
    created_at,
    updated_at,
  ];
}
