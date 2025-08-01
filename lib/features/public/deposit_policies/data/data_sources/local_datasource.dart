import 'dart:convert';
import 'package:pashboi/features/public/deposit_policies/data/models/deposit_policy_model.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DepositPolicyLocalDataSource {
  Future<List<DepositPolicyModel>> fetchLoanPoliciesByCategoryId(
    FetchPageProps props,
  );
  Future<void> storeDepositPolicies(List<DepositPolicyModel> depositPolicies);
}

class DepositPolicyLocalDataSourceImpl implements DepositPolicyLocalDataSource {
  final SharedPreferences _sharedPreferences;

  static const String _depositPolicyKey = 'deposit_policy_key';

  DepositPolicyLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<DepositPolicyModel>> fetchLoanPoliciesByCategoryId(
    FetchPageProps props,
  ) async {
    try {
      final jsonString = _sharedPreferences.getString(_depositPolicyKey);
      if (jsonString == null) throw Exception('Invalid response format');

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => DepositPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch deposit policies from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeDepositPolicies(
    List<DepositPolicyModel> depositPolicies,
  ) async {
    final depositPolicyData = jsonEncode(
      depositPolicies.map((e) => (e as dynamic).toJson()).toList(),
    );
    await _sharedPreferences.setString(_depositPolicyKey, depositPolicyData);
  }
}
