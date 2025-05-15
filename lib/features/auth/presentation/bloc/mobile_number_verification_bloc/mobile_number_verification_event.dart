part of 'mobile_number_verification_bloc.dart';

abstract class VerifyMobileNumberEvent extends Equatable {
  const VerifyMobileNumberEvent();

  @override
  List<Object?> get props => [];
}

class SubmitMobileNumber extends VerifyMobileNumberEvent {
  final String mobileNumber;
  final bool isRegistered;

  const SubmitMobileNumber({
    required this.mobileNumber,
    required this.isRegistered,
  });

  @override
  List<Object?> get props => [mobileNumber, isRegistered];
}
