import 'dart:convert';
import 'package:pashboi/features/public/service/data/models/service_policy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServicePolicyLocalDataSource {
  Future<List<ServicePolicyModel>> fetchServicePolicy();
  Future<void> storeServicePolicy(List<ServicePolicyModel> servicePolicy);
}

class ServicePolicyLocalDataSourceImpl implements ServicePolicyLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String servicePolicyName = 'service_policy_data';

  ServicePolicyLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ServicePolicyModel>> fetchServicePolicy() async {
    try {
      final jsonString = sharedPreferences.getString(servicePolicyName);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => ServicePolicyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch loan policies from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeServicePolicy(
    List<ServicePolicyModel> servicePolicy,
  ) async {
    final servicePolicyData = jsonEncode(
      servicePolicy.map((e) => (e as dynamic).toJson()).toList(),
    );
    await sharedPreferences.setString(servicePolicyName, servicePolicyData);
  }
}
