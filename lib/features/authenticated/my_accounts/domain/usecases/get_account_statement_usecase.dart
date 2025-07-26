import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class GetAccountStatementProps extends BaseRequestProps {
  final String accountNumber;
  final String? fromDate;
  final String? toDate;

  const GetAccountStatementProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.accountNumber,
    required this.fromDate,
    required this.toDate,
  });
}

class GetAccountStatementUseCase
    extends UseCase<List<AccountTransactionEntity>, GetAccountStatementProps> {
  final DepositAccountRepository depositAccountRepository;

  GetAccountStatementUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<List<AccountTransactionEntity>> call(
    GetAccountStatementProps params,
  ) async {
    return await depositAccountRepository.getAccountStatement(params);
  }
}
