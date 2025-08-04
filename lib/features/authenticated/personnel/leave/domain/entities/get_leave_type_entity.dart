import 'package:pashboi/core/entities/entity.dart';

class LeaveTypeEntity extends Entity<String> {
  final String leaveTypeCode;
  final String leaveType;

  LeaveTypeEntity({
    super.id,
    required this.leaveTypeCode,
    required this.leaveType,
  });

  @override
  List<Object?> get props => [id, leaveType, leaveTypeCode];
}
