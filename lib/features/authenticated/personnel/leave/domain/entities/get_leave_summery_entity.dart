import 'package:pashboi/core/entities/entity.dart';

class LeaveSummeryEntity extends Entity<String> {
  final String leaveTypeCode;
  final String leaveType;
  final String employeeId;
  final String totalLeaveDays;
  final String balance;
  final String totalLeaveApplied;
  final String lastApplicationDate;
  final String maxBalance;
  final String minimumNoticeDay;
  final String maxLeaveAtATime;
  final String documentsRequiredDays;
  final String maximumHourLeave;
  final String applyBeforeDays;
  final String isFallbackRequired;
  final String maximumFallbackDays;
  final String isEditable;
  final String isRejoinDateRequired;
  final String enableFutureDateApplication;
  final String enablePastDateApplication;
  final String withTime;
  final String enablePresentDateApplication;
  final String requireToDate;
  LeaveSummeryEntity({
    required String id,
    required this.leaveTypeCode,
    required this.leaveType,
    required this.employeeId,
    required this.totalLeaveDays,
    required this.balance,
    required this.totalLeaveApplied,
    required this.lastApplicationDate,
    required this.maxBalance,
    required this.minimumNoticeDay,
    required this.maxLeaveAtATime,
    required this.documentsRequiredDays,
    required this.maximumHourLeave,
    required this.applyBeforeDays,
    required this.isFallbackRequired,
    required this.maximumFallbackDays,
    required this.isEditable,
    required this.isRejoinDateRequired,
    required this.enableFutureDateApplication,
    required this.enablePastDateApplication,
    required this.withTime,
    required this.enablePresentDateApplication,
    required this.requireToDate,
  }) : super(id: id);

  @override
  List<Object?> get props => [
    id,
    leaveTypeCode,
    leaveType,
    employeeId,
    totalLeaveDays,
    balance,
    totalLeaveApplied,
    lastApplicationDate,
    maxBalance,
    minimumNoticeDay,
    maxLeaveAtATime,
    documentsRequiredDays,
    maximumHourLeave,
    applyBeforeDays,
    isFallbackRequired,
    maximumFallbackDays,
    isEditable,
    isRejoinDateRequired,
    enableFutureDateApplication,
    enablePastDateApplication,
    withTime,
    enablePresentDateApplication,
    requireToDate,
  ];
}
