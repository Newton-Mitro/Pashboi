import 'package:dartz/dartz.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';

class OpenDepositAccountUseCaseParams {
  final String accountType;
  final String accountName;
  final String accountNumber;
  final String accountBalance;
  final String accountCurrency;
  final String accountDescription;
  final String otpRegId;
  final String mobileNumber;

  const OpenDepositAccountUseCaseParams({
    required this.accountType,
    required this.accountName,
    required this.accountNumber,
    required this.accountBalance,
    required this.accountCurrency,
    required this.accountDescription,
    required this.otpRegId,
    required this.mobileNumber,
  });
}

class OpenDepositAccountUseCase implements UseCase<void, NoParams> {
  OpenDepositAccountUseCase();

  @override
  ResultFuture call(NoParams params) async {
    return Right(null);
  }
}
