// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:pashboi/core/usecases/usecase.dart';
// import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
// import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/submit_leave_application_usecase.dart';

// part 'submit_leave_application_event.dart';
// part 'submit_leave_application_state.dart';

// class SubmitLeaveApplicationBloc
//     extends Bloc<SubmitLeaveApplicationEvent, SubmitLeaveApplicationState> {
//   final GetAuthUserUseCase getAuthUserUseCase;
//   final SubmitLeaveApplicationUseCase submitLeaveApplicationUseCase;

//   SubmitLeaveApplicationBloc({
//     required this.getAuthUserUseCase,
//     required this.submitLeaveApplicationUseCase,
//   }) : super(SubmitLeaveApplicationInitial()) {
//     on<SubmitLeaveApplicationEvent>(_submitLeaveApplication);
//   }

//   Future<void> _submitLeaveApplication(
//     SubmitLeaveApplicationEvent event,
//     Emitter<SubmitLeaveApplicationState> emit,
//   ) async {
    
//     emit(const SubmitLeaveApplicationLoading());

//     final userResult = await getAuthUserUseCase.call(NoParams());

//     await userResult.fold(
//       (failure) async {
//         emit(SubmitLeaveApplicationError(failure.message));
//       },
//       (authData) async {
//         final user = authData.user;
//         final LeaveApplication = await submitLeaveApplicationUseCase.call(
//           SubmitLeaveApplicationProps(
//             remarks: event.remarks,
//             fallbackEmployeeCode: event.fallbackEmployeeCode,
//             rejoiningDate: event.rejoiningDate,
//             toDate: event.toDate,
//             fromDate: event.fromDate,
//             leaveTypeCode: event.leaveTypeCode,
//             leaveApplicationId: event.leaveApplicationId,
//             leaveStageRemarks: event.leaveStageRemarks,
//             email: user.loginEmail,
//             userId: user.userId,
//             rolePermissionId: user.roleId,
//             personId: user.personId,
//             employeeCode: user.employeeCode,
//             mobileNumber: user.regMobile,
//           ),
//         ); 

       

//         final result = await submitLeaveApplicationProps.call(props);

//         result.fold(
//           (failure) {
//             emit(SubmitLeaveApplicationError(failure.message));
//           },
//           (success) {
//             emit(SubmitLeaveApplicationSuccess(success.message));
//           },
//         );
//       },
//     );
//   }
// }
