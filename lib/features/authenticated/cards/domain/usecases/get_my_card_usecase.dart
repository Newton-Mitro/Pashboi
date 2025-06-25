import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/cards/domain/entities/debit_card_entity.dart';
import 'package:pashboi/features/authenticated/cards/domain/repositories/card_repository.dart';

class GetMyCardUseCaseProps extends BaseRequestProps {
  const GetMyCardUseCaseProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class GetMyCardUseCase extends UseCase<DebitCardEntity, GetMyCardUseCaseProps> {
  final CardRepository cardRepository;

  GetMyCardUseCase({required this.cardRepository});

  @override
  ResultFuture<DebitCardEntity> call(GetMyCardUseCaseProps params) async {
    return cardRepository.getMyCard(params);
  }
}
