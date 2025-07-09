import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/account_util_repository.dart';

class FetchAccountTenuresProps extends BaseRequestProps {
  final String productCode;

  const FetchAccountTenuresProps({
    required this.productCode,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchAccountTenuresUseCase
    extends UseCase<List<TenureEntity>, FetchAccountTenuresProps> {
  final AccountUtilRepository accountUtilRepository;

  FetchAccountTenuresUseCase({required this.accountUtilRepository});

  @override
  ResultFuture<List<TenureEntity>> call(FetchAccountTenuresProps props) async {
    return accountUtilRepository.fetchAccountTenures(props);
  }
}
