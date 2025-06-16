import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/half_circle_printer.dart';

class ProgressSubmitButton extends StatefulWidget {
  final VoidCallback onSubmit;
  final String label;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color progressColor;
  final int duration;
  final bool enabled; // <-- new parameter

  const ProgressSubmitButton({
    super.key,
    required this.onSubmit,
    this.label = "Hold to Submit",
    this.height = 100,
    this.width = double.infinity,
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    this.progressColor = Colors.red,
    this.duration = 3,
    this.enabled = true, // <-- default true
  });

  @override
  State<ProgressSubmitButton> createState() => _ProgressSubmitButtonState();
}

class _ProgressSubmitButtonState extends State<ProgressSubmitButton> {
  Timer? _timer;
  double _progress = 0.0;

  void _startTimer() {
    if (!widget.enabled) return; // <-- prevent action if disabled

    const tick = Duration(milliseconds: 50);
    int ticks = 0;
    final int maxTicks = (widget.duration * 1000) ~/ tick.inMilliseconds;

    _timer = Timer.periodic(tick, (timer) {
      setState(() {
        ticks++;
        _progress = ticks / maxTicks;
      });

      if (ticks >= maxTicks) {
        _timer?.cancel();
        widget.onSubmit();
        setState(() {
          _progress = 0.0;
        });
      }
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    setState(() {
      _progress = 0.0;
    });
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.enabled
            ? widget.backgroundColor
            : widget.backgroundColor.withOpacity(0.5);
    final foregroundColor =
        widget.enabled
            ? widget.foregroundColor
            : widget.foregroundColor.withOpacity(0.5);

    return GestureDetector(
      onLongPressStart: (_) => _startTimer(),
      onLongPressEnd: (_) => _cancelTimer(),
      child: AbsorbPointer(
        absorbing: !widget.enabled,
        child: Opacity(
          opacity: widget.enabled ? 1.0 : 0.6,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: HalfCirclePainter(
                    progress: _progress,
                    backgroundColor: backgroundColor,
                    progressColor: widget.progressColor,
                  ),
                ),
                Positioned(
                  bottom: widget.height / 3,
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      color: foregroundColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
