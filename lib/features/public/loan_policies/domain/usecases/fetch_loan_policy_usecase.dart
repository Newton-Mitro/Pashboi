import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/repositories/loan_policy_repository.dart';

class FetchLoanPolicyProps {
  final String categoryId;

  FetchLoanPolicyProps({required this.categoryId});
}

class FetchLoanPolicyUseCase
    extends UseCase<List<LoanPolicyEntity>, FetchLoanPolicyProps> {
  final LoanPolicyRepository loanPolicyRepository;

  FetchLoanPolicyUseCase({required this.loanPolicyRepository});

  @override
  ResultFuture<List<LoanPolicyEntity>> call(FetchLoanPolicyProps props) async {
    return loanPolicyRepository.findLoanPoliciesByCategoryId(props);
  }
}
