import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/get_leave_type_blance_entity.dart';

abstract class LeaveTypeBalanceRepository {
  ResultFuture<LeaveTypeBalanceDto> getLeaveTypeBalance(props);
}
