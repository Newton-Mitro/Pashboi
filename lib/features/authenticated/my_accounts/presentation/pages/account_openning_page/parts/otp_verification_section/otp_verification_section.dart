import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class OtpVerificationSection extends StatelessWidget {
  final String? otpError;
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;
  final bool isWaiting;
  final int otpDuration;
  final CountDownController countDownController;
  final VoidCallback onResendOtp;
  final void Function(String value, int index) onOtpChanged;
  final VoidCallback clearOtpFields;
  final VoidCallback onOtpComplete;

  const OtpVerificationSection({
    super.key,
    required this.otpControllers,
    required this.focusNodes,
    required this.isWaiting,
    required this.otpDuration,
    required this.countDownController,
    required this.onResendOtp,
    required this.onOtpChanged,
    required this.clearOtpFields,
    required this.onOtpComplete,
    required this.otpError,
  });

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    Locales.string(context, "otp_verification_page_title"),
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
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 50,
                          height: 50,
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: focusNodes[index],
                            autofocus: index == 0,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: InputDecoration(
                              filled: true,
                              counterText: '',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: context.theme.colorScheme.secondary,
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: context.theme.colorScheme.secondary,
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
                              if (value.isNotEmpty) {
                                otpControllers[index].text = value[0];
                                otpControllers[index].selection =
                                    const TextSelection.collapsed(offset: 1);
                              }
                              onOtpChanged(value, index);
                            },
                          ),
                        );
                      }),
                    ),
                    if (otpError != null && otpError!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          otpError!,
                          style: TextStyle(
                            color: context.theme.colorScheme.error,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (isWaiting)
                      Column(
                        children: [
                          CircularCountDownTimer(
                            duration: otpDuration,
                            initialDuration: 0,
                            controller: countDownController,
                            width: 60,
                            height: 60,
                            ringColor: Colors.grey.shade300,
                            fillColor: context.theme.colorScheme.secondary,
                            backgroundColor: Colors.transparent,
                            strokeWidth: 6.0,
                            strokeCap: StrokeCap.round,
                            isTimerTextShown: true,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.theme.colorScheme.onSurface,
                            ),
                            isReverse: true,
                            autoStart: true,
                            onComplete: onOtpComplete,
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
                      TextButton(
                        onPressed: () {
                          clearOtpFields();
                          onResendOtp();
                        },
                        child: Text(
                          Locales.string(
                            context,
                            "otp_verification_page_reseend_otp_button",
                          ),
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
