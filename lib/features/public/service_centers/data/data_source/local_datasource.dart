import 'dart:convert';
import 'package:pashboi/features/public/service_centers/data/models/service_center_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServiceCenterLocalDataSource {
  Future<List<ServiceCenterModel>> fetchServiceCenter();
  Future<void> storeServiceCenter(List<ServiceCenterModel> serviceCenter);
}

class ServiceCenterLocalDataSourceImpl implements ServiceCenterLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String serviceCenterName = 'service_Center_data';

  ServiceCenterLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ServiceCenterModel>> fetchServiceCenter() async {
    try {
      final jsonString = sharedPreferences.getString(serviceCenterName);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => ServiceCenterModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch service center from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeServiceCenter(
    List<ServiceCenterModel> serviceCenter,
  ) async {
    final serviceCenterData = jsonEncode(
      serviceCenter.map((e) => (e as dynamic).toJson()).toList(),
    );
    await sharedPreferences.setString(serviceCenterName, serviceCenterData);
  }
}
