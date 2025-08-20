import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/submit_leave_application_usecase.dart';

part 'submit_leave_application_event.dart';
part 'submit_leave_application_state.dart';

class SubmitLeaveApplicationBloc
    extends Bloc<SubmitLeaveApplicationEvent, SubmitLeaveApplicationState> {
  final GetAuthUserUseCase getAuthUserUseCase;
  final SubmitLeaveApplicationUseCase submitLeaveApplicationUseCase;

  SubmitLeaveApplicationBloc({
    required this.getAuthUserUseCase,
    required this.submitLeaveApplicationUseCase,
  }) : super(SubmitLeaveApplicationInitial()) {
    on<SubmitLeaveApplicationSubmitted>(_submitLeaveApplication);
  }

  Future<UserEntity?> _getAuthenticatedUser(
    Emitter<SubmitLeaveApplicationState> emit,
  ) async {
    final authUser = await getAuthUserUseCase(NoParams());
    return authUser.fold((failure) {
      emit(
        const SubmitLeaveApplicationError('Failed to load user information'),
      );
      return null;
    }, (success) => success.user);
  }

  Future<void> _submitLeaveApplication(
    SubmitLeaveApplicationSubmitted event,
    Emitter<SubmitLeaveApplicationState> emit,
  ) async {
    final errors = <String, String>{};

    // if (event.beneficiaryName.trim().isEmpty) {
    //   errors['beneficiaryName'] = 'Please enter beneficiary name';
    // }

    // if (event.accountNumber.trim().isEmpty) {
    //   errors['accountNumber'] = 'Please enter account number';
    // }

    // if (errors.isNotEmpty) {
    //   emit(SubmitLeaveApplicationError(errors));
    //   return;
    // }

    emit(const SubmitLeaveApplicationLoading());

    try {
      final user = await _getAuthenticatedUser(emit);
      if (user == null) return;

      final result = await submitLeaveApplicationUseCase.call(
        SubmitLeaveApplicationProps(
          remarks: event.remarks,
          fallbackEmployeeCode: event.fallbackEmployeeCode,
          rejoiningDate: event.rejoiningDate,
          toDate: event.toDate,
          fromDate: event.fromDate,
          leaveTypeCode: event.leaveTypeCode,
          leaveStageRemarks: event.leaveStageRemarks,
          formTime: event.fromDate,
          toTime: event.toDate,
          email: user.loginEmail,
          userId: user.userId,
          rolePermissionId: user.roleId,
          personId: user.personId,
          employeeCode: user.employeeCode,
          mobileNumber: user.regMobile,
        ),
      );

      result.fold(
        (failure) => emit(SubmitLeaveApplicationError(failure.message)),
        (success) => emit(SubmitLeaveApplicationSuccess(success)),
      );
    } catch (e) {
      emit(SubmitLeaveApplicationError(e.toString()));
    }
  }
}
