import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class GetMyAccountsProps extends BaseRequestProps {
  final int accountHolderPersonId;

  const GetMyAccountsProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.accountHolderPersonId,
  });
}

class GetMyAccountsUseCase
    extends UseCase<List<DepositAccountEntity>, GetMyAccountsProps> {
  final DepositAccountRepository depositAccountRepository;

  GetMyAccountsUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<List<DepositAccountEntity>> call(
    GetMyAccountsProps params,
  ) async {
    return await depositAccountRepository.getMyAccounts(params);
  }
}
