import 'package:flutter/widgets.dart';

abstract class StepperStep extends StatefulWidget {
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final bool isFirstStep;
  final bool isLastStep;

  const StepperStep({
    super.key,
    this.onNext,
    this.onPrevious,
    this.isFirstStep = false,
    this.isLastStep = false,
  });
}
