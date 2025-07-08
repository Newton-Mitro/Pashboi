import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/public/pages/data/models/page_model.dart';

abstract class PageRemoteDataSource {
  Future<PageModel> fetchPageDataByPageSlug(props);
}

class PageRemoteDataSourceImpl implements PageRemoteDataSource {
  final ProductApiService productApiService;

  PageRemoteDataSourceImpl({required this.productApiService});

  @override
  Future<PageModel> fetchPageDataByPageSlug(props) async {
    try {
      final response = await productApiService.get(
        "${ApiUrls.getPageByPageSlug}/${props.pageSlug}",
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data['pages'];

        if (data == null) {
          throw Exception('Invalid response: expected a JSON object');
        }
        return PageModel.fromJson(data);
      } else {
        throw Exception('Failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
