import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/leave_type_blance_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/get_leave_type_blance_dto.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/leave_type_balance_repository.dart';

class LeaveTypeBalanceRepositoriesImpl implements LeaveTypeBalanceRepository {
  final LeaveTypeBalanceDataSource leaveTypeBalancedataSource;
  final NetworkInfo networkInfo;

  LeaveTypeBalanceRepositoriesImpl({
    required this.leaveTypeBalancedataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<LeaveTypeBalanceDto> getLeaveTypeBalance(props) async {
    try {
      final result = await leaveTypeBalancedataSource.fetchLeaveTypeBalance(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
