import 'package:flutter/material.dart';

class CircularCountdownTimer extends StatelessWidget {
  final int secondsRemaining;
  final VoidCallback onCompleted;
  final Color color;
  final Color backgroundColor;

  const CircularCountdownTimer({
    super.key,
    required this.secondsRemaining,
    required this.onCompleted,
    required this.color,
    this.backgroundColor = const Color(0xFFE0E0E0),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: Duration(seconds: secondsRemaining),
      onEnd: onCompleted,
      builder: (context, value, _) {
        final secondsLeft = (secondsRemaining * value).ceil();
        final minutes = (secondsLeft ~/ 60).toString().padLeft(2, '0');
        final seconds = (secondsLeft % 60).toString().padLeft(2, '0');

        return Column(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: value,
                    strokeWidth: 6,
                    backgroundColor: backgroundColor,
                    color: color,
                  ),
                  Text(
                    "$minutes:$seconds",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text("OTP expires in"),
          ],
        );
      },
    );
  }
}
