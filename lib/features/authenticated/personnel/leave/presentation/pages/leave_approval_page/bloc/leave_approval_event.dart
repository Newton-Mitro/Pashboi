part of 'leave_approval_bloc.dart';

sealed class LeaveApprovalEvent extends Equatable {
  const LeaveApprovalEvent();

  @override
  List<Object> get props => [];
}

final class FetchLeaveApprovals extends LeaveApprovalEvent {
  const FetchLeaveApprovals();
}
