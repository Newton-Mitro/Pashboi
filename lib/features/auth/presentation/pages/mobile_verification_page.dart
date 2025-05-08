import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
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
    (index) => TextEditingController(),
  ); // List of 6 controllers
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  ); // Focus nodes for each OTP box

  bool _otpSent = false;
  bool _isWaiting = false;
  int _secondsRemaining = 60; // 3 minutes countdown
  Timer? _resendTimer;

  @override
  void dispose() {
    _resendTimer?.cancel();
    _phoneController.dispose();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _isWaiting = true;
      _secondsRemaining = 60; // Set to 3 minutes (180 seconds)
    });

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
      });

      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          _isWaiting = false;
        });
      }
    });
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
    });

    _startResendCountdown();

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
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp == "123456") {
      // On successful verification, navigate using the passed routeName
      Navigator.pushReplacementNamed(context, widget.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'On Snap',
            message: "Invalid OTP",
            contentType: ContentType.failure,
          ),
        ),
      );
    }
  }

  // Function to move focus to the next field automatically
  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      // Move focus to the previous field if the value is cleared
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }
  }

  // Function to clear OTP fields
  void _clearOtpFields() {
    for (var controller in _otpControllers) {
      controller.clear();
    }
    for (var focusNode in _focusNodes) {
      focusNode.unfocus();
    }
    setState(() {
      _isWaiting = false;
      _secondsRemaining = 60; // Reset to 3 minutes
    });
  }

  @override
  void initState() {
    super.initState();
    // Add focus listeners to each OTP box
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          // Clear the OTP field when it gains focus
          _otpControllers[i].clear();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, "mobile_verification_page_title")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: context.theme.colorScheme.secondary,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        // Ensure only one digit is entered (replace previous digit)
                        if (value.isNotEmpty) {
                          // Replace the old value with the new value
                          _otpControllers[index].text = value.substring(0, 1);
                          _otpControllers[index]
                              .selection = TextSelection.collapsed(offset: 1);
                        }
                        _onOtpChanged(value, index);
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              _isWaiting
                  ? Text(
                    '${Locales.string(context, "mobile_verification_page_otp_expired_in_text")} $_secondsRemaining ${Locales.string(context, "mobile_verification_page_otp_expire_in_time_text")}',
                  )
                  : TextButton(
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
                        color: context.theme.colorScheme.onPrimary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
              const SizedBox(height: 10),
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
    );
  }
}
