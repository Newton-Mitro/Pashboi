import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';

abstract class LoanPolicyRepository {
  ResultFuture<List<LoanPolicyEntity>> findDepositPoliciesByCategoryId(
    FetchDepositPllicyProps props,
  );
}
