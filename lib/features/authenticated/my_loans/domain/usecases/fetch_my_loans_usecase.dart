import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/entities/loan_account_entity.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/repositories/loan_repository.dart';

class FetchMyLoansProps extends BaseRequestProps {
  const FetchMyLoansProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchMyLoansUseCase
    extends UseCase<List<LoanAccountEntity>, FetchMyLoansProps> {
  final LoanRepository loanRepository;

  FetchMyLoansUseCase({required this.loanRepository});

  @override
  ResultFuture<List<LoanAccountEntity>> call(FetchMyLoansProps props) async {
    return loanRepository.fetchMyLoans(props);
  }
}
