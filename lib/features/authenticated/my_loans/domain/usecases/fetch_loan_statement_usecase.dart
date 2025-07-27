import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/repositories/loan_repository.dart';

class FetchLoanStatementProps extends BaseRequestProps {
  final String loanNumber;
  final String? fromDate;
  final String? toDate;

  const FetchLoanStatementProps({
    required this.loanNumber,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.fromDate,
    required this.toDate,
  });
}

class FetchLoanStatementUseCase
    extends UseCase<List<LoanTransactionEntity>, FetchLoanStatementProps> {
  final LoanRepository loanRepository;

  FetchLoanStatementUseCase({required this.loanRepository});

  @override
  ResultFuture<List<LoanTransactionEntity>> call(
    FetchLoanStatementProps props,
  ) async {
    return loanRepository.fetchLoanStatement(props);
  }
}
