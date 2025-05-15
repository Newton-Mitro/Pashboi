import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/auth/domain/usecases/verify_otp_usecase.dart';

part 'otp_verification_event.dart';
part 'otp_verification_state.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpVerificationBloc({required this.verifyOtpUseCase})
    : super(OtpVerificationInitial()) {
    on<OtpChanged>((event, emit) {
      // No state change for local otp field in this version (stateless input tracking)
    });

    on<VerifyOtpSubmitted>((event, emit) async {
      emit(OtpVerificationLoading());

      final result = await verifyOtpUseCase(
        VerifyOtpParams(
          mobileNumber: event.mobileNumber,
          otpRegId: event.otpRegId,
          otpValue: event.otp,
          requestFrom: 'Web',
        ),
      );

      result.fold(
        (failure) => emit(OtpVerificationFailure(failure.message)),
        (_) => emit(OtpVerificationSuccess("OTP Verified Successfully")),
      );
    });
  }
}
