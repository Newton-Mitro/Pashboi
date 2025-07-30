import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class OpenDepositAccountParams extends BaseRequestProps {
  final String accountType;
  final String accountName;
  final String accountNumber;
  final String accountBalance;
  final String accountCurrency;
  final String accountDescription;
  final String otpRegId;
  final String otpValue;

  const OpenDepositAccountParams({
    required this.accountType,
    required this.accountName,
    required this.accountNumber,
    required this.accountBalance,
    required this.accountCurrency,
    required this.accountDescription,
    required this.otpRegId,
    required this.otpValue,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class OpenDepositAccountUseCase
    implements UseCase<void, OpenDepositAccountParams> {
  final DepositAccountRepository depositAccountRepository;

  OpenDepositAccountUseCase({required this.depositAccountRepository});

  @override
  ResultFuture call(OpenDepositAccountParams params) async {
    return await depositAccountRepository.openDepositAccount(params);
  }
}
