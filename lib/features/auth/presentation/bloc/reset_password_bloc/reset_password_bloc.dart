import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_registered_mobile_usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/reset_password_usecase.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  final GetRegisteredMobileUseCase getRegisteredMobileUseCase;

  ResetPasswordBloc({
    required this.resetPasswordUseCase,
    required this.getRegisteredMobileUseCase,
  }) : super(ResetPasswordInitial()) {
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<GetRegisteredMobileRequested>(_onGetRegisteredMobileRequested);
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<ResetPasswordState> emit,
  ) async {
    // Local form validation
    final errors = <String, String>{};

    if (event.mobileNumber.trim().isEmpty) {
      errors['mobile'] = 'Mobile number is required';
    } else if (!_isValidMobileNumber(event.mobileNumber)) {
      errors['mobile'] = 'Enter a valid mobile number';
    }

    if (event.password.trim().isEmpty) {
      errors['password'] = 'Password is required';
    } else if (event.password.length < 6) {
      errors['password'] = 'Password must be at least 6 characters';
    }

    if (errors.isNotEmpty) {
      emit(ResetPasswordValidationError(errors));
      return;
    }

    emit(ResetPasswordLoading());

    final result = await resetPasswordUseCase(
      ResetPasswordParams(
        mobileNumber: event.mobileNumber,
        password: event.password,
      ),
    );

    result.fold((failure) {
      if (failure is ValidationFailure) {
        emit(ResetPasswordValidationError(failure.errors));
      } else {
        emit(ResetPasswordFailure(message: failure.message));
      }
    }, (_) => emit(ResetPasswordSuccess()));
  }

  Future<void> _onGetRegisteredMobileRequested(
    GetRegisteredMobileRequested event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());

    final result = await getRegisteredMobileUseCase(NoParams());

    result.fold(
      (failure) => emit(ResetPasswordFailure(message: failure.message)),
      (mobile) => emit(RegisteredMobileLoaded(mobile)),
    );
  }

  bool _isValidMobileNumber(String number) {
    final mobileRegex = RegExp(r'^\d{10,15}$'); // You can customize this
    return mobileRegex.hasMatch(number);
  }
}
