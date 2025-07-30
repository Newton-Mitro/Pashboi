import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/my_app/data/models/app_status_model.dart';

abstract class AppStatusRemoteDataSource {
  Future<AppStatusModel> getAppStatus(int version);
}

class AppStatusRemoteDataSourceImpl implements AppStatusRemoteDataSource {
  final ApiService apiService;

  AppStatusRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AppStatusModel> getAppStatus(int version) async {
    try {
      final response = await apiService.post(
        ApiUrls.getAppConfig,
        data: {"Data": version},
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];
        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage == null || statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            final jsonResponse = JsonUtil.decodeModelList(dataString);
            final model = AppStatusModel.fromJson(jsonResponse[0]);
            return model;
          }
        }
        throw ServerException(message: "Server Error");
      } else {
        throw ServerException(message: "Server Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
