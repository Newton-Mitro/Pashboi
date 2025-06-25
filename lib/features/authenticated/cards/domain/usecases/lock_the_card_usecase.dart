import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';

class LockTheCardUseCaseProps extends BaseRequestProps {
  final String cardNumber;
  final String accountNumber;
  final String nameOnCard;

  const LockTheCardUseCaseProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.cardNumber,
    required this.accountNumber,
    required this.nameOnCard,
  });
}

class LockTheCardUseCase extends UseCase<String, LockTheCardUseCaseProps> {
  final CardRepository cardRepository;

  LockTheCardUseCase({required this.cardRepository});

  @override
  ResultFuture<String> call(LockTheCardUseCaseProps props) async {
    return cardRepository.lockTheCard(props);
  }
}
