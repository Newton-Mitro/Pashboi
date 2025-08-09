import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/repositories/deposit_repository.dart';

class FetchScheduledDepositsProps extends BaseRequestProps {
  final String otherField;

  const FetchScheduledDepositsProps({
    required this.otherField,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchScheduledDepositsUseCase
    extends UseCase<List<DepositRequestEntity>, FetchScheduledDepositsProps> {
  final DepositRepository depositRepository;

  FetchScheduledDepositsUseCase({required this.depositRepository});

  @override
  ResultFuture<List<DepositRequestEntity>> call(
    FetchScheduledDepositsProps props,
  ) async {
    return depositRepository.fetchScheduledDeposits(props);
  }
}
