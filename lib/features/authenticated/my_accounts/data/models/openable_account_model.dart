import 'package:pashboi/features/authenticated/my_accounts/domain/entities/openable_account_entity.dart';

class OpenableAccountModel extends OpenableAccountEntity {
  OpenableAccountModel({
    required super.id,
    required super.productCode,
    required super.productName,
    required super.productType,
    required super.productTypeName,
    required super.isActive,
    required super.description,
  });

  factory OpenableAccountModel.fromJson(Map<String, dynamic> json) {
    return OpenableAccountModel(
      id: json['ProductId'],
      productCode: json['ProductCode'],
      productName: json['ProductName'],
      productType: json['ProductType'],
      productTypeName: json['ProductTypeName'],
      isActive: json['IsActive'],
      description: json['Description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductId': id,
      'ProductCode': productCode,
      'ProductName': productName,
      'ProductType': productType,
      'IsActive': isActive,
      'Description': description,
    };
  }
}
