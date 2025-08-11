import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/bloc/otp_bloc.dart';

class OtpVerificationSection extends StatefulWidget {
  final void Function() resendOTP;
  const OtpVerificationSection({super.key, required this.resendOTP});

  @override
  State<OtpVerificationSection> createState() => _OtpVerificationSectionState();
}

class _OtpVerificationSectionState extends State<OtpVerificationSection> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  late CountDownController _countDownController;
  bool _hasStartedCountdown = false;

  /// Tracks if focus change was triggered programmatically (not user tap)
  bool _isProgrammaticFocusChange = false;

  @override
  void initState() {
    super.initState();

    final otpState = context.read<OtpBloc>().state;
    final otpLength = otpState.otpValues.length;

    _otpControllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());
    _countDownController = CountDownController();

    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          if (_isProgrammaticFocusChange && i > 0) {
            _otpControllers[i - 1].clear();
            context.read<OtpBloc>().add(
              OtpDigitChanged(index: i - 1, value: ''),
            );
          }
          // Reset flag regardless of focus origin
          _isProgrammaticFocusChange = false;
        }
      });
    }

    // Clear OTP fields at the start
    context.read<OtpBloc>().add(ClearOtpFields());

    // Start countdown immediately if state is waiting
    if (otpState.isWaiting && !_hasStartedCountdown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _countDownController.start();
        _hasStartedCountdown = true;
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OtpBloc, OtpState>(
      listenWhen:
          (previous, current) => previous.isWaiting != current.isWaiting,
      listener: (context, state) {
        if (state.isWaiting) {
          _hasStartedCountdown = false;
          Future.microtask(() {
            if (state.countdownRemaining > 0) {
              _countDownController.restart(duration: state.countdownRemaining);
              _hasStartedCountdown = true;
            }
          });
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          for (int i = 0; i < _otpControllers.length; i++) {
            _otpControllers[i].text = state.otpValues[i];
            _otpControllers[i].selection = TextSelection.collapsed(
              offset: state.otpValues[i].length,
            );
          }

          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                  border: Border.all(color: context.theme.colorScheme.primary),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Locales.string(
                            context,
                            "otp_verification_page_title",
                          ),
                          style: TextStyle(
                            color: context.theme.colorScheme.onPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            Locales.string(
                              context,
                              "otp_verification_page_instruction",
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(_otpControllers.length, (
                              index,
                            ) {
                              return SizedBox(
                                width: 50,
                                height: 50,
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: _focusNodes[index],
                                  autofocus: index == 0,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    counterText: '',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color:
                                            context.theme.colorScheme.secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color:
                                            context.theme.colorScheme.secondary,
                                        width: 1.0,
                                      ),
                                    ),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 10,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.length > 1) {
                                      // Take only first digit if pasted/multiple chars
                                      _otpControllers[index].text = value[0];
                                      _otpControllers[index].selection =
                                          const TextSelection.collapsed(
                                            offset: 1,
                                          );
                                    }

                                    if (value.isNotEmpty) {
                                      context.read<OtpBloc>().add(
                                        OtpDigitChanged(
                                          index: index,
                                          value: value[0],
                                        ),
                                      );
                                      if (index < _otpControllers.length - 1) {
                                        // Mark programmatic focus change
                                        _isProgrammaticFocusChange = true;
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(_focusNodes[index + 1]);
                                      } else {
                                        _focusNodes[index].unfocus();
                                      }
                                    } else {
                                      // If user deletes digit, move focus back to previous box
                                      if (index > 0) {
                                        _isProgrammaticFocusChange = true;
                                        FocusScope.of(
                                          context,
                                        ).requestFocus(_focusNodes[index - 1]);
                                      }
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 20),
                          if (state.isWaiting)
                            Column(
                              children: [
                                CircularCountDownTimer(
                                  duration: state.countdownRemaining,
                                  initialDuration: 0,
                                  controller: _countDownController,
                                  width: 60,
                                  height: 60,
                                  ringColor: Colors.grey.shade300,
                                  fillColor:
                                      Theme.of(context).colorScheme.secondary,
                                  backgroundColor: Colors.transparent,
                                  strokeWidth: 6.0,
                                  strokeCap: StrokeCap.round,
                                  isTimerTextShown: true,
                                  isReverse: true,
                                  isReverseAnimation: true,
                                  autoStart: true,
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                  onComplete: () {
                                    context.read<OtpBloc>().add(
                                      TickOtpCountdown(0),
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  Locales.string(
                                    context,
                                    "otp_verification_page_otp_expired_in_text",
                                  ),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                Text("Don't receive the OTP?"),
                                TextButton(
                                  onPressed: () {
                                    context.read<OtpBloc>().add(
                                      ClearOtpFields(),
                                    );
                                    context.read<OtpBloc>().add(
                                      ResendOtpRequested(),
                                    );
                                    widget.resendOTP();
                                  },
                                  child: Text(
                                    Locales.string(
                                      context,
                                      "otp_verification_page_reseend_otp_button",
                                    ),
                                    style: TextStyle(
                                      color:
                                          context.theme.colorScheme.onSurface,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
