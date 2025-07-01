import 'package:pashboi/features/public/deposit_policies/domain/entities/deposit_product_entity.dart';

class DepositProductModel extends DepositProductEntity {
  DepositProductModel({
    String? id,
    String? title,
    String? slug,
    String? order,
    String? short_description,
    String? long_description,
    String? attachment_url,
    String? attachment_path,
    String? attachment_name,
    String? attachment_mime,
    String? publish_status,
    String? product_categories_id,
    String? created_at,
    String? updated_at,
  }) : super(
         id: id,
         title: title,
         slug: slug,
         order: order,
         short_description: short_description,
         long_description: long_description,
         attachment_url: attachment_url,
         attachment_name: attachment_name,
         attachment_mime: attachment_mime,
         attachment_path: attachment_path,
         publish_status: publish_status,
         product_categories_id: product_categories_id,
         created_at: created_at,
         updated_at: updated_at,
       );
  factory DepositProductModel.formJson(Map<String, dynamic> json) {
    return DepositProductModel(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      order: json['order'],
      short_description: json['short_description'],
      long_description: json['long_description'],
      attachment_url: json['attachment_url'],
      attachment_path: json['attachment_path'],
      attachment_name: json['attachment_name'],
      attachment_mime: json['attachment_mime'],
      publish_status: json['publish_status'],
      product_categories_id: json['product_categories_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'order': order,
      'short_description': short_description,
      'long_description': long_description,
      'attachment_url': attachment_url,
      'attachment_path': attachment_path,
      'attachment_name': attachment_name,
      'attachment_mime': attachment_mime,
      'publish_status': publish_status,
      'product_categories_id': product_categories_id,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}
