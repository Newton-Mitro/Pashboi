import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/deposit_policies/domain/entities/deposit_product_entity.dart';

abstract class DepositProductRepository {
  ResultFuture<List<DepositProductEntity>> getDepositProducts();
}
