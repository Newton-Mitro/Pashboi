import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';

class SubmitTransferBankToDcProps extends BaseRequestProps {
  final String accountNumber;
  final String accountHolderName;
  final String repeatMonths;
  final String bankRoutingNumber;
  final String transactionReceipt;
  final String transactionNumber;
  final int accountId;
  final String accountType;
  final String cardNumber;
  final String depositDate;
  final int dayOfMonth;
  final int ledgerId;
  final String cardPin;
  final double totalDepositAmount;
  final String otpRegId;
  final String otpValue;
  final double amount;
  final String toAccountNumber;
  final String nameOnCard;
  final DepositAccountEntity account;

  const SubmitTransferBankToDcProps({
    required this.accountNumber,
    required this.accountHolderName,
    required this.repeatMonths,
    required this.bankRoutingNumber,
    required this.transactionReceipt,
    required this.transactionNumber,
    required this.accountId,
    required this.accountType,
    required this.cardNumber,
    required this.depositDate,
    required this.dayOfMonth,
    required this.ledgerId,
    required this.cardPin,
    required this.totalDepositAmount,
    required this.otpRegId,
    required this.otpValue,
    required this.amount,
    required this.toAccountNumber,
    required this.nameOnCard,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.account,
  });
}

class SubmitTransferBankToDcUseCase
    extends UseCase<String, SubmitTransferBankToDcProps> {
  final TransferRepository transferRepository;

  SubmitTransferBankToDcUseCase({required this.transferRepository});

  @override
  ResultFuture<String> call(SubmitTransferBankToDcProps props) async {
    return transferRepository.submitTransferBankToDc(props);
  }
}
