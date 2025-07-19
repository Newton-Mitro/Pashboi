import 'dart:convert';
import 'package:pashboi/features/public/service_centers/data/models/service_center_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServiceCenterLocalDataSource {
  Future<List<ServiceCenterModel>> fetchServiceCenter();
  Future<void> storeServiceCenter(List<ServiceCenterModel> serviceCenter);
}

class ServiceCenterLocalDataSourceImpl implements ServiceCenterLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final String _serviceCenterKey = 'service_Center_key';

  ServiceCenterLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<ServiceCenterModel>> fetchServiceCenter() async {
    try {
      final jsonString = _sharedPreferences.getString(_serviceCenterKey);
      if (jsonString == null) throw Exception('Invalid response format');
      ;

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
    await _sharedPreferences.setString(_serviceCenterKey, serviceCenterData);
  }
}
