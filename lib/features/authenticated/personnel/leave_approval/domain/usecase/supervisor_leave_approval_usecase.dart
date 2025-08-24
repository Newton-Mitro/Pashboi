// import 'package:pashboi/core/requests/base_request_props.dart';
// import 'package:pashboi/core/types/typedef.dart';
// import 'package:pashboi/core/usecases/usecase.dart';
// import 'package:pashboi/features/authenticated/personnel/leave_approval/domain/entities/supervisor_leave_approval_entites.dart';
// import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
// import 'package:pashboi/features/authenticated/sureties/domain/repositories/surety_repository.dart';

// class SupervisorLeaveApprovalUseCase extends BaseRequestProps {
//   const SupervisorLeaveApprovalUseCase({
//     required super.email,
//     required super.userId,
//     required super.rolePermissionId,
//     required super.personId,
//     required super.employeeCode,
//     required super.mobileNumber,
//   });
// }

// class NameUseCase extends UseCase<SupervisorLeaveApprovalEntities, SupervisorLeaveApprovalUseCase> {
//   final RepositoryInterface repositoryInterface;

//   NameUseCase({required this.repositoryInterface});

//   @override
//   ResultFuture<SupervisorLeaveApprovalEntities> call(SupervisorLeaveApprovalUseCase props) async {
//     return repositoryInterface.functionName(props);
//   }
// }
