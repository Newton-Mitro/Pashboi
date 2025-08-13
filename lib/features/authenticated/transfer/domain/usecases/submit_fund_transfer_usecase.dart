import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';

class SubmitFundTransferProps extends BaseRequestProps {
  final double amount;
  final String otpRegId;
  final String otpValue;
  final String accountNumber;
  final String toAccountNumber;
  final String accountType;
  final String cardNumber;
  final String nameOnCard;
  final String cardPin;

  const SubmitFundTransferProps({
    required this.amount,
    required this.otpRegId,
    required this.otpValue,
    required this.accountNumber,
    required this.toAccountNumber,
    required this.accountType,
    required this.cardNumber,
    required this.nameOnCard,
    required this.cardPin,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class SubmitFundTransferUseCase
    extends UseCase<String, SubmitFundTransferProps> {
  final TransferRepository transferRepository;

  SubmitFundTransferUseCase({required this.transferRepository});

  @override
  ResultFuture<String> call(SubmitFundTransferProps props) async {
    return transferRepository.submitFundTransfer(props);
  }
}
