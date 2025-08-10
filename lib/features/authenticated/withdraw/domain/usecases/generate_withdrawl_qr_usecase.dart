import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/withdraw/domain/repositories/withdrawl_repository.dart';

class GenerateWithdrawlQrProps extends BaseRequestProps {
  final double amount;
  final String otpRegId;
  final String otpValue;
  final String accountNumber;
  final String cardNumber;
  final String nameOnCard;
  final String cardPin;

  const GenerateWithdrawlQrProps({
    required this.amount,
    required this.otpRegId,
    required this.otpValue,
    required this.accountNumber,
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

class GenerateWithdrawlQrUseCase
    extends UseCase<String, GenerateWithdrawlQrProps> {
  final WithdrawlRepository withdrawlRepository;

  GenerateWithdrawlQrUseCase({required this.withdrawlRepository});

  @override
  ResultFuture<String> call(GenerateWithdrawlQrProps props) async {
    return withdrawlRepository.generateWithdrawlQr(props);
  }
}
