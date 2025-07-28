part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
}

class OtpDigitChanged extends OtpEvent {
  final int index;
  final String value;

  const OtpDigitChanged({required this.index, required this.value});

  @override
  List<Object> get props => [index, value];
}

class ClearOtpFields extends OtpEvent {
  @override
  List<Object> get props => [];
}

class StartOtpCountdown extends OtpEvent {
  @override
  List<Object> get props => [];
}

class TickOtpCountdown extends OtpEvent {
  final int remaining;

  const TickOtpCountdown(this.remaining);

  @override
  List<Object> get props => [remaining];
}

class ResendOtpRequested extends OtpEvent {
  @override
  List<Object> get props => [];
}
