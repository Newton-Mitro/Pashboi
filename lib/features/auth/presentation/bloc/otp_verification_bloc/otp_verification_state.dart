part of 'otp_verification_bloc.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {
  final String message;

  const OtpVerificationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpVerificationFailure extends OtpVerificationState {
  final String error;

  const OtpVerificationFailure(this.error);

  @override
  List<Object?> get props => [error];
}
