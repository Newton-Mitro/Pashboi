import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/get_leave_type_blance_dto.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/get_leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/search_employee_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_blance_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_usecase.dart';

abstract class LeaveRepository {
  ResultFuture<LeaveTypeBalanceDto> getLeaveTypeBalance(
    LeaveTypeBalanceProps props,
  );

  ResultFuture<List<LeaveTypeEntity>> getLeaveType(LeaveTypeProps props);

  ResultFuture<List<SearchEmployeeEntity>> getSearchEmployee(props);

  ResultFuture<String> submitLeaveApplication(props);
}
