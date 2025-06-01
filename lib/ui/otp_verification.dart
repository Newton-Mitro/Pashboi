import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'dart:async';

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  static const int totalTime = 120; // total time in seconds (2 min)
  int remainingTime = totalTime;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double progress = remainingTime / totalTime;
    int minutes = remainingTime ~/ 60;
    int seconds = remainingTime % 60;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Card's",
              style: TextStyle(
                color: context.theme.colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.onPrimary,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.mobile,
                              size: 35,
                              color: context.theme.colorScheme.surface,
                            ),
                            SizedBox(height: 15),
                            Text(
                              "OTP Verification",
                              style: TextStyle(
                                color: context.theme.colorScheme.surface,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                "Please enter the verification code that we have sent to your registered number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: context.theme.colorScheme.surface,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            Center(
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: CircularProgressIndicator(
                                        value: progress,
                                        strokeWidth: 4,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFFCBD4E1),
                                            ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OtpTextField(
                                numberOfFields: 6,
                                borderColor:
                                    context.theme.colorScheme.onPrimary,
                                showFieldAsBox: true,
                                textStyle: TextStyle(
                                  color: context.theme.colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                ),
                                onCodeChanged: (String code) {},
                                onSubmit: (String verificationCode) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Verification Code"),
                                        content: Text(
                                          'Code entered is $verificationCode',
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),

                            SizedBox(height: 15),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "Didn’t receive the code? ",
                                    style: TextStyle(
                                      color: context.theme.colorScheme.surface,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Reset timer
                                      setState(() {
                                        remainingTime = totalTime;
                                        timer?.cancel();
                                        startTimer();
                                      });
                                    },
                                    child: Text(
                                      "Resend OTP",
                                      style: TextStyle(
                                        color:
                                            context.theme.colorScheme.secondary,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AppPrimaryButton(
                  iconAfter: Icon(Icons.arrow_forward),
                  label: "Verify",
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
