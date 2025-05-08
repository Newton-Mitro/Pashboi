import 'dart:io';

import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/my_app/data/models/app_status_model.dart';

abstract class AppStatusRemoteDataSource {
  Future<AppStatusModel> getAppStatus();
}

class AppStatusRemoteDataSourceImpl implements AppStatusRemoteDataSource {
  final ApiService apiService;

  AppStatusRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AppStatusModel> getAppStatus() async {
    try {
      final response = await apiService.get('/LoginApi/MFSAppConfig');

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['data'][0];
        if (data == null) throw Exception('Invalid response format');

        return AppStatusModel.fromJson(data);
      } else {
        throw Exception(
          'Failed to fetch app status with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
