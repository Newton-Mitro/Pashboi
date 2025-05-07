import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TooltipComponent extends StatefulWidget {
  final String tooltipMessage;
  final Widget child;

  const TooltipComponent({
    required this.tooltipMessage,
    required this.child,
    super.key,
  });

  @override
  State<TooltipComponent> createState() => _TooltipComponentState();
}

class _TooltipComponentState extends State<TooltipComponent> {
  late SuperTooltipController _tooltipController;

  @override
  void initState() {
    super.initState();
    _tooltipController = SuperTooltipController();
  }

  @override
  void dispose() {
    _tooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _tooltipController.showTooltip();
      },
      child: SuperTooltip(
        showBarrier: true,
        controller: _tooltipController,
        content: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.tooltipMessage,
              softWrap: true,
              style: TextStyle(color: context.theme.colorScheme.onSurface),
            ),
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
