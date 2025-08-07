import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/repositories/deposit_repository.dart';

class FetchBkashServiceChargeProps extends BaseRequestProps {
  final double amount;

  const FetchBkashServiceChargeProps({
    required this.amount,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchBkashServiceChargeUseCase
    extends UseCase<double, FetchBkashServiceChargeProps> {
  final DepositRepository depositRepository;

  FetchBkashServiceChargeUseCase({required this.depositRepository});

  @override
  ResultFuture<double> call(FetchBkashServiceChargeProps props) async {
    return depositRepository.fetchBkashServiceCharge(props);
  }
}
