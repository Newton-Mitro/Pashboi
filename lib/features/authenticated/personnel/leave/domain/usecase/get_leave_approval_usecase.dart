import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/leave_application_entites.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/leave_repository.dart';

class GetLeaveApprovalProps extends BaseRequestProps {
  final String formDate;
  final String toDate;

  const GetLeaveApprovalProps({
    required this.formDate,
    required this.toDate,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class GetLeaveApprovalUseCase
    extends UseCase<List<LeaveApplicationEntities>, GetLeaveApprovalProps> {
  final LeaveRepository leaveRepository;

  GetLeaveApprovalUseCase({required this.leaveRepository});

  @override
  ResultFuture<List<LeaveApplicationEntities>> call(
    GetLeaveApprovalProps props,
  ) async {
    return leaveRepository.getLeaveApproval(props);
  }
}
