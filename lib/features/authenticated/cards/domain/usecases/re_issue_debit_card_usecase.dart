import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';

class ReIssueDebitCardUsecaseProps extends BaseRequestProps {
  final String cardNumber;
  final String cardTypeCode;
  final bool virtualCard;
  final String nameOnCard;

  const ReIssueDebitCardUsecaseProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.cardNumber,
    required this.cardTypeCode,
    required this.virtualCard,
    required this.nameOnCard,
  });
}

class ReIssueDebitCardUsecase
    extends UseCase<String, ReIssueDebitCardUsecaseProps> {
  final CardRepository cardRepository;

  ReIssueDebitCardUsecase({required this.cardRepository});

  @override
  ResultFuture<String> call(ReIssueDebitCardUsecaseProps props) async {
    return cardRepository.reIssueDebitCard(props);
  }
}
