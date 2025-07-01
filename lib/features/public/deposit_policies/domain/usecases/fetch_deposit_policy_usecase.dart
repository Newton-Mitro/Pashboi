import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_policy_repository.dart';

class FetchDepositPllicyProps {
  final String categoryId;

  FetchDepositPllicyProps({required this.categoryId});
}

class FetchDepositPolicyUseCase
    extends UseCase<List<DepositPolicyEntity>, FetchDepositPllicyProps> {
  final DepositPolicyRepository depositPolicyRepository;

  FetchDepositPolicyUseCase({required this.depositPolicyRepository});

  @override
  ResultFuture<List<DepositPolicyEntity>> call(
    FetchDepositPllicyProps props,
  ) async {
    return depositPolicyRepository.findDepositPoliciesByCategoryId(props);
  }
}
