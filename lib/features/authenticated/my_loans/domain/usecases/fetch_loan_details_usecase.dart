import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_account_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/repositories/loan_repository.dart';

class FetchLoanDetailsProps extends BaseRequestProps {
  final String loanNumber;

  const FetchLoanDetailsProps({
    required this.loanNumber,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchLoanDetailsUseCase
    extends UseCase<LoanAccountEntity, FetchLoanDetailsProps> {
  final LoanRepository loanRepository;

  FetchLoanDetailsUseCase({required this.loanRepository});

  @override
  ResultFuture<LoanAccountEntity> call(FetchLoanDetailsProps props) async {
    return loanRepository.fetchLoanDetails(props);
  }
}
