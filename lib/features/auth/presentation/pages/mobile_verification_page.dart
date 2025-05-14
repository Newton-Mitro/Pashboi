import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class MobileVerificationPage extends StatefulWidget {
  final String routeName;

  const MobileVerificationPage({super.key, required this.routeName});

  @override
  State<MobileVerificationPage> createState() => _MobileVerificationPageState();
}

class _MobileVerificationPageState extends State<MobileVerificationPage> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _otpSent = false;
  bool _isWaiting = false;
  final int _otpDuration = 60;
  final CountDownController _countDownController = CountDownController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _otpControllers[i].clear();
        }
      });
    }
  }

  @override
  void dispose() {
    try {
      _countDownController.pause(); // 🔒 Safely pause countdown
    } catch (e) {
      // Avoid crash if already disposed
      debugPrint('CountdownController pause failed: $e');
    }

    _phoneController.dispose();

    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }

    super.dispose();
  }

  void _sendOtp() {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Info',
            message: 'Please enter your mobile number',
            contentType: ContentType.failure,
          ),
        ),
      );
      return;
    }

    setState(() {
      _otpSent = true;
      _isWaiting = true;
    });

    if (mounted) {
      try {
        _countDownController.restart(duration: _otpDuration);
      } catch (e) {
        debugPrint('CountdownController restart failed: $e');
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Info',
          message: 'OTP sent to ${_phoneController.text}',
          contentType: ContentType.success,
        ),
      ),
    );
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp == "123456") {
      Navigator.pushReplacementNamed(context, widget.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Oh Snap',
            message: "Invalid OTP",
            contentType: ContentType.failure,
          ),
        ),
      );
    }
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  void _clearOtpFields() {
    for (var c in _otpControllers) {
      c.clear();
    }
    for (var f in _focusNodes) {
      f.unfocus();
    }
    setState(() {
      _isWaiting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "mobile_verification_page_title")),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.center, child: AppLogo(width: 150)),
              const SizedBox(height: 40),
              AppTextInput(
                controller: _phoneController,
                label: Locales.string(
                  context,
                  "mobile_verification_page_mobile_number_label",
                ),
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
              ),
              const SizedBox(height: 16),

              if (_otpSent) ...[
                Text(
                  "Please enter the OTP \nsent to your mobile number.",
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
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
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
                            _otpControllers[index].text = value.substring(0, 1);
                            _otpControllers[index].selection =
                                const TextSelection.collapsed(offset: 1);
                          }
                          _onOtpChanged(value, index);
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                if (_isWaiting)
                  Column(
                    children: [
                      CircularCountDownTimer(
                        duration: _otpDuration,
                        initialDuration: 0,
                        controller: _countDownController,
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
                        onComplete: () {
                          if (mounted) {
                            setState(() => _isWaiting = false);
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        Locales.string(
                          context,
                          "mobile_verification_page_otp_expired_in_text",
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
                      _clearOtpFields();
                      _sendOtp();
                    },
                    child: Text(
                      Locales.string(
                        context,
                        "mobile_verification_page_reseend_otp_button",
                      ),
                      style: TextStyle(
                        color: context.theme.colorScheme.onSurface,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                AppPrimaryButton(
                  label: Locales.string(
                    context,
                    "mobile_verification_page_verify_otp_button",
                  ),
                  onPressed: _verifyOtp,
                  iconBefore: Icon(
                    Icons.check_circle,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                ),
              ] else
                AppPrimaryButton(
                  label: Locales.string(
                    context,
                    "mobile_verification_page_send_otp_button",
                  ),
                  onPressed: _sendOtp,
                  iconBefore: Icon(
                    Icons.send,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
