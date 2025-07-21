import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _countdownTimer;

  OtpBloc({int otpLength = 6})
    : super(
        OtpState(
          otpValues: List.generate(otpLength, (_) => ''),
          isWaiting: true,
          countdownRemaining: 30,
        ),
      ) {
    on<OtpDigitChanged>(_onDigitChanged);
    on<ClearOtpFields>(_onClearOtp);
    on<StartOtpCountdown>(_onStartCountdown);
    on<TickOtpCountdown>(_onTick);
    on<ResendOtpRequested>(_onResend);
  }

  void _onDigitChanged(OtpDigitChanged event, Emitter<OtpState> emit) {
    final updated = List<String>.from(state.otpValues);
    updated[event.index] = event.value;
    emit(state.copyWith(otpValues: updated));
  }

  void _onClearOtp(ClearOtpFields event, Emitter<OtpState> emit) {
    emit(
      state.copyWith(
        otpValues: List.generate(state.otpValues.length, (_) => ''),
        shouldClearFields: true,
      ),
    );
  }

  void _onStartCountdown(StartOtpCountdown event, Emitter<OtpState> emit) {
    _countdownTimer?.cancel();
    const int duration = 30;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = duration - timer.tick;
      if (remaining <= 0) {
        timer.cancel();
      }
      add(TickOtpCountdown(remaining));
    });

    emit(state.copyWith(isWaiting: true, countdownRemaining: duration));
  }

  void _onTick(TickOtpCountdown event, Emitter<OtpState> emit) {
    if (event.remaining <= 0) {
      emit(state.copyWith(isWaiting: false, countdownRemaining: 0));
    } else {
      emit(state.copyWith(countdownRemaining: event.remaining));
    }
  }

  void _onResend(ResendOtpRequested event, Emitter<OtpState> emit) {
    // Trigger API resend if needed, e.g. repository call
    add(StartOtpCountdown());
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
