import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/openable_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/account_util_repository.dart';

class FetchOpenableAccountsProps extends BaseRequestProps {
  const FetchOpenableAccountsProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchOpenableAccountsUseCase
    extends UseCase<List<OpenableAccountEntity>, FetchOpenableAccountsProps> {
  final AccountUtilRepository accountUtilRepository;

  FetchOpenableAccountsUseCase({required this.accountUtilRepository});

  @override
  ResultFuture<List<OpenableAccountEntity>> call(
    FetchOpenableAccountsProps props,
  ) async {
    return accountUtilRepository.fetchOpenableAccounts(props);
  }
}
