part of 'submit_leave_application_bloc.dart';

sealed class SubmitLeaveApplicationEvent extends Equatable {
  const SubmitLeaveApplicationEvent();

  @override
  List<Object> get props => [];
}

class SubmitLeaveApplicationSubmitted extends SubmitLeaveApplicationEvent {
  final String remarks;
  final String fallbackEmployeeCode;
  final String rejoiningDate;
  final String toDate;
  final String fromDate;
  final String formTime;
  final String toTime;
  final String leaveTypeCode;
  final String leaveStageRemarks;

  const SubmitLeaveApplicationSubmitted({
    required this.remarks,
    required this.fallbackEmployeeCode,
    required this.rejoiningDate,
    required this.toDate,
    required this.formTime,
    required this.toTime,
    required this.fromDate,
    required this.leaveTypeCode,
    required this.leaveStageRemarks,
  });

  @override
  List<Object> get props => [
    remarks,
    fallbackEmployeeCode,
    rejoiningDate,
    toDate,
    fromDate,
    formTime,
    toTime,
    leaveTypeCode,
    leaveStageRemarks,
  ];
}
