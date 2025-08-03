import 'package:flutter/material.dart';
import 'package:pashboi/core/constants/app_icons.dart';

class BkashIcon extends StatefulWidget {
  final double size;

  const BkashIcon({super.key, this.size = 40});

  @override
  State<BkashIcon> createState() => _BkashIconState();
}

class _BkashIconState extends State<BkashIcon>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Image.asset(AppIcons.pathToBkashIcon, width: widget.size);
  }
}
