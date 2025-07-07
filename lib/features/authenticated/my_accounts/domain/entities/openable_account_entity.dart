import 'package:pashboi/core/entities/entity.dart';

class OpenableAccountEntity extends Entity<int> {
  final String productCode;
  final String productName;
  final int productType;
  final bool isActive;
  final String description;

  OpenableAccountEntity({
    super.id,
    required this.productCode,
    required this.productName,
    required this.productType,
    required this.isActive,
    required this.description,
  });

  @override
  List<Object?> get props => [
    id,
    productCode,
    productName,
    productType,
    isActive,
    description,
  ];
}
