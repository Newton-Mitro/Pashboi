import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class GetAccountDetailsProps extends BaseRequestProps {
  final String accountHolderPersonId;

  const GetAccountDetailsProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.accountHolderPersonId,
  });
}

class GetAccountDetailsUseCase
    extends UseCase<DepositAccountEntity, GetAccountDetailsProps> {
  final DepositAccountRepository depositAccountRepository;

  GetAccountDetailsUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<DepositAccountEntity> call(GetAccountDetailsProps params) async {
    return await depositAccountRepository.getAccountDetails(params);
  }
}
