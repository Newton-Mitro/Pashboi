import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';

class AddOperatingAccountProps extends BaseRequestProps {
  final int operatorId;
  final int accountHolderId;
  final int accountHolderInfoId;

  const AddOperatingAccountProps({
    required this.operatorId,
    required this.accountHolderId,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.accountHolderInfoId,
  });
}

class AddOperatingAccountUseCase
    extends UseCase<String, AddOperatingAccountProps> {
  final DepositAccountRepository depositAccountRepository;

  AddOperatingAccountUseCase({required this.depositAccountRepository});

  @override
  ResultFuture<String> call(AddOperatingAccountProps props) async {
    return depositAccountRepository.addOperatingAccount(props);
  }
}
