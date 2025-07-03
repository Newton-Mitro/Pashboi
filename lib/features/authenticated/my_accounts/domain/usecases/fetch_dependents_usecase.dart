import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class FetchDependentsProps extends BaseRequestProps {
  final int dependentPersonId;

  const FetchDependentsProps({
    required this.dependentPersonId,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchDependentsUseCase
    extends UseCase<List<DepositAccountEntity>, FetchDependentsProps> {
  final DepositAccountRepository depositAccountRepository;

  FetchDependentsUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<List<DepositAccountEntity>> call(
    FetchDependentsProps props,
  ) async {
    return depositAccountRepository.fetchDependents(props);
  }
}
