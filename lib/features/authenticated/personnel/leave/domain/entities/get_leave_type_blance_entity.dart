import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/get_leave_summery_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/leave_info_entity.dart';

class LeaveTypeBalanceEntity extends Entity<String> {
  final LeaveInfoEntity leaveInfo;
  final LeaveSummeryEntity leaveSummary;
  LeaveTypeBalanceEntity({
    super.id,
    required this.leaveInfo,
    required this.leaveSummary,
  });

  @override
  List<Object?> get props => [id, leaveInfo, leaveSummary];
}
