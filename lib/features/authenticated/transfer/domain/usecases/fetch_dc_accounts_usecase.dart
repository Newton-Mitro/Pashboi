import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/entities/dc_bank_entity.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';

class FetchDcBankAccountsProps extends BaseRequestProps {
  final String otherField;

  const FetchDcBankAccountsProps({
    required this.otherField,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchDcBankAccountsUseCase
    extends UseCase<List<DcBankEntity>, FetchDcBankAccountsProps> {
  final TransferRepository transferRepository;

  FetchDcBankAccountsUseCase({required this.transferRepository});

  @override
  ResultFuture<List<DcBankEntity>> call(FetchDcBankAccountsProps props) async {
    return transferRepository.fetchDcBankAccounts(props);
  }
}
