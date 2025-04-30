import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pashboi/core/widgets/app_logo.dart';

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
  int _secondsRemaining = 180; // 3 minutes countdown
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
      _secondsRemaining = 180; // Set to 3 minutes (180 seconds)
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
        const SnackBar(content: Text("Please enter your mobile number")),
      );
      return;
    }

    setState(() {
      _otpSent = true;
    });

    _startResendCountdown();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('OTP sent to ${_phoneController.text}')),
    );
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp == "123456") {
      // On successful verification, navigate using the passed routeName
      Navigator.pushReplacementNamed(context, widget.routeName);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
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
      _secondsRemaining = 180; // Reset to 3 minutes
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
      appBar: AppBar(title: const Text("Mobile Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Logo at the top
            Align(
              alignment: Alignment.center,
              child: AppLogo(width: 200, height: 200),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            if (_otpSent) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50, // Set width of each OTP input box
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      autofocus: index == 0,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
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
                  ? Text('Resend in $_secondsRemaining seconds')
                  : TextButton(
                    onPressed: () {
                      _clearOtpFields();
                      _sendOtp();
                    },
                    child: const Text('Resend OTP'),
                  ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: const Text("Verify"),
              ),
            ] else
              ElevatedButton(
                onPressed: _sendOtp,
                child: const Text("Send OTP"),
              ),
          ],
        ),
      ),
    );
  }
}
