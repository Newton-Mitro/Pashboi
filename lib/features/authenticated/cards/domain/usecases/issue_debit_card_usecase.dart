import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';

class IssueDebitCardUseCaseProps extends BaseRequestProps {
  final String cardTypeCode;
  final bool withCard;
  const IssueDebitCardUseCaseProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.cardTypeCode,
    required this.withCard,
  });
}

class IssueDebitCardUseCase
    extends UseCase<String, IssueDebitCardUseCaseProps> {
  final CardRepository cardRepository;

  IssueDebitCardUseCase({required this.cardRepository});

  @override
  ResultFuture<String> call(IssueDebitCardUseCaseProps props) async {
    return cardRepository.issueDebitCard(props);
  }
}
