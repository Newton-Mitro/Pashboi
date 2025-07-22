part of 'otp_bloc.dart';

class OtpState extends Equatable {
  final List<String> otpValues;
  final bool isWaiting;
  final int countdownRemaining;
  final bool shouldClearFields;

  const OtpState({
    required this.otpValues,
    required this.isWaiting,
    required this.countdownRemaining,
    this.shouldClearFields = false,
  });

  OtpState copyWith({
    List<String>? otpValues,
    bool? isWaiting,
    int? countdownRemaining,
    bool? shouldClearFields,
  }) {
    return OtpState(
      otpValues: otpValues ?? this.otpValues,
      isWaiting: isWaiting ?? this.isWaiting,
      countdownRemaining: countdownRemaining ?? this.countdownRemaining,
      shouldClearFields: shouldClearFields ?? false,
    );
  }

  @override
  List<Object> get props => [
    otpValues,
    isWaiting,
    countdownRemaining,
    shouldClearFields,
  ];
}
