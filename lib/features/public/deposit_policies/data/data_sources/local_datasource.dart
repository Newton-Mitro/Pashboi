import 'dart:convert';

import 'package:pashboi/features/public/deposit_policies/data/models/deposit_policy_model.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DepositPolicyLocalDataSource {
  Future<List<DepositPolicyModel>> fetchDepositPoliciesByCategoryId(
    FetchPageProps props,
  );
}

class DepositPolicyLocalDataSourceImpl implements DepositPolicyLocalDataSource {
  final SharedPreferences sharedPreferences;

  DepositPolicyLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<DepositPolicyModel>> fetchDepositPoliciesByCategoryId(
    FetchPageProps props,
  ) async {
    try {
      final jsonString = sharedPreferences.getString(props.toString());
      if (jsonString == null) return [];

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
}
