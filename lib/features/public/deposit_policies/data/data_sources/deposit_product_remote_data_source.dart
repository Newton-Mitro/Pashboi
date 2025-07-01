import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/public/deposit_policies/data/models/deposit_product.dart';

class DepositProductRemoteDataSource {
  final ApiService apiService;

  DepositProductRemoteDataSource({required this.apiService});

  Future<List<DepositProductModel>> getDepositProductsDataSource() async {
    try {
      final response = await apiService.get(ApiUrls.getAllDepositProduct);

      print(response.statusCode);

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['Data'];
        if (data == null) throw Exception('Invalid response format');
        return data;
      } else {
        throw Exception(
          'Registration failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
