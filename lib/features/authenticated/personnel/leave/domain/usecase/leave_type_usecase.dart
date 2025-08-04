// import 'package:pashboi/core/requests/base_request_props.dart';
// import 'package:pashboi/core/types/typedef.dart';
// import 'package:pashboi/core/usecases/usecase.dart';
// import 'package:pashboi/features/authenticated/personnel/employee/domain/entities/get_leave_type_entity.dart';
// import 'package:pashboi/features/authenticated/personnel/employee/domain/repositories/leave_type_repository.dart';

// class LeaveTypeProps extends BaseRequestProps {
//   const LeaveTypeProps({
//     required super.email,
//     required super.userId,
//     required super.rolePermissionId,
//     required super.personId,
//     required super.employeeCode,
//     required super.mobileNumber,
//   });
// }

// class LeaveTypeUseCaseUseCase
//     extends UseCase<List<LeaveTypeEntity>, LeaveTypeProps> {
//   final LeaveTypeRepository leaveTypeRepository;

//   LeaveTypeUseCaseUseCase({required this.leaveTypeRepository});

//   @override
//   ResultFuture<List<LeaveTypeEntity>> call(LeaveTypeProps props) async {
//     return leaveTypeRepository.functionName(props);
//   }
// }
