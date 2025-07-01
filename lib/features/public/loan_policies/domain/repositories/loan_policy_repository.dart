import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/usecases/fetch_loant_policy_usecase.dart';

abstract class LoanPolicyRepository {
  ResultFuture<List<LoanPolicyEntity>> findLoanPoliciesByCategoryId(
    FetchLoanPolicyProps props,
  );
}
