import 'dart:convert';

import 'package:pashboi/features/public/loan_policies/data/models/loan_policy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoanPolicyLocalDataSource {
  Future<List<LoanPolicyModel>> fetchLoanPoliciesByCategoryId();
  Future<void> storeLoanPolicies(List<LoanPolicyModel> loanPolicies);
}

class LoanPolicyLocalDataSourceImpl implements LoanPolicyLocalDataSource {
  final SharedPreferences _sharedPreferences;

  final String _loanPolicyKey = 'loan_policy_key';

  LoanPolicyLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<LoanPolicyModel>> fetchLoanPoliciesByCategoryId() async {
    try {
      final jsonString = _sharedPreferences.getString(_loanPolicyKey);
      if (jsonString == null) throw Exception('Invalid response format');

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => LoanPolicyModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch loan policies from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeLoanPolicies(List<LoanPolicyModel> loanPolicies) async {
    final loanPolicyData = jsonEncode(
      loanPolicies.map((e) => (e as dynamic).toJson()).toList(),
    );
    await _sharedPreferences.setString(_loanPolicyKey, loanPolicyData);
  }
}
