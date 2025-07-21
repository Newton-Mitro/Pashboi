import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';

class VerifyCardPinUseCaseProps extends BaseRequestProps {
  final String cardNumber;
  final String nameOnCard;
  final String cardPIN;
  final String accountNumber;

  const VerifyCardPinUseCaseProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.cardNumber,
    required this.nameOnCard,
    required this.cardPIN,
    required this.accountNumber,
  });
}

class VerifyCardPinUseCase extends UseCase<String, VerifyCardPinUseCaseProps> {
  final CardRepository cardRepository;

  VerifyCardPinUseCase({required this.cardRepository});

  @override
  ResultFuture<String> call(VerifyCardPinUseCaseProps params) async {
    return cardRepository.verifyCardPIN(params);
  }
}
