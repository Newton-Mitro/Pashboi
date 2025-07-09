import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/account_util_repository.dart';

class FetchAccountTenureAmountsProps extends BaseRequestProps {
  final String productCode;
  final String duration;

  const FetchAccountTenureAmountsProps({
    required this.productCode,
    required this.duration,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchAccountTenureAmountsUseCase
    extends UseCase<List<TenureAmountEntity>, FetchAccountTenureAmountsProps> {
  final AccountUtilRepository accountUtilRepository;

  FetchAccountTenureAmountsUseCase({required this.accountUtilRepository});

  @override
  ResultFuture<List<TenureAmountEntity>> call(
    FetchAccountTenureAmountsProps props,
  ) async {
    return accountUtilRepository.fetchAccountTenureAmounts(props);
  }
}
