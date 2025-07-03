import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class FetchOperatingAccountsProps extends BaseRequestProps {
  final int dependentPersonId;

  const FetchOperatingAccountsProps({
    required this.dependentPersonId,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchOperatingAccountsUseCase
    extends UseCase<List<DepositAccountEntity>, FetchOperatingAccountsProps> {
  final DepositAccountRepository depositAccountRepository;

  FetchOperatingAccountsUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<List<DepositAccountEntity>> call(
    FetchOperatingAccountsProps props,
  ) async {
    return depositAccountRepository.fetchOperatingAccounts(props);
  }
}
