import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/get_leave_type_blance_dto.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_blance_usecase.dart';

abstract class LeaveTypeBalanceRepository {
  ResultFuture<LeaveTypeBalanceDto> getLeaveTypeBalance(
    LeaveTypeBalanceProps props,
  );
}
