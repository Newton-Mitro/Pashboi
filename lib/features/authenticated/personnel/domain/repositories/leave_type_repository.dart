import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/domain/entities/get_leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/domain/usecase/leave_type_usecase.dart';

abstract class LeaveTypeRepository {
  ResultFuture<List<LeaveTypeEntity>> getLeaveType(LeaveTypeProps props);
}
