import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';

abstract class DepositPolicyRepository {
  ResultFuture<List<DepositPolicyEntity>> findDepositPoliciesByCategoryId(
    FetchDepositPllicyProps props,
  );
}
