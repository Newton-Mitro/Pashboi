import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';

class SubmitTransferToBkashProps extends BaseRequestProps {
  final double amount;
  final String otpRegId;
  final String otpValue;
  final String accountNumber;
  final String toBkashNumber;
  final String accountType;
  final String cardNumber;
  final String nameOnCard;
  final String cardPin;

  const SubmitTransferToBkashProps({
    required this.amount,
    required this.otpRegId,
    required this.otpValue,
    required this.accountNumber,
    required this.toBkashNumber,
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

class SubmitTransferToBkashUseCase
    extends UseCase<String, SubmitTransferToBkashProps> {
  final TransferRepository transferRepository;

  SubmitTransferToBkashUseCase({required this.transferRepository});

  @override
  ResultFuture<String> call(SubmitTransferToBkashProps props) async {
    return transferRepository.submitTransferToBkash(props);
  }
}
