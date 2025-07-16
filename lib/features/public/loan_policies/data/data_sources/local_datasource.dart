import 'dart:convert';

import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:pashboi/features/public/loan_policies/data/models/loan_policy_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoanPolicyLocalDataSource {
  Future<List<LoanPolicyModel>> fetchLoanPoliciesByCategoryId();
  Future<void> storeLoanPolicies(List<LoanPolicyModel> loanPolicies);
}

class LoanPolicyLocalDataSourceImpl implements LoanPolicyLocalDataSource {
  final SharedPreferences sharedPreferences;

  final String loanPolicyName = 'loan_policy';

  LoanPolicyLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<LoanPolicyModel>> fetchLoanPoliciesByCategoryId() async {
    try {
      final jsonString = sharedPreferences.getString(loanPolicyName);
      if (jsonString == null) return [];

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
    await sharedPreferences.setString(loanPolicyName, loanPolicyData);
  }
}
