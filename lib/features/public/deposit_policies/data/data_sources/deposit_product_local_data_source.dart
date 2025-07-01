import 'dart:convert';

import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/features/public/deposit_policies/data/models/deposit_product.dart';

class DepositProductLocalDataSource {
  final LocalStorage localStorage;
  static const String _depositProductsKey = 'deposit_products';

  DepositProductLocalDataSource({required this.localStorage});

  Future<void> saveDepositProducts(
    List<DepositProductModel> depositProducts,
  ) async {
    final jsonList = depositProducts.map((e) => e.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await localStorage.saveString(_depositProductsKey, jsonString);
  }
}
