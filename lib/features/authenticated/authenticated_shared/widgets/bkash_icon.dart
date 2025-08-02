import 'package:flutter/material.dart';
import 'package:pashboi/core/constants/app_icons.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class BkashIcon extends StatefulWidget {
  const BkashIcon({super.key});

  @override
  State<BkashIcon> createState() => BkashIconState();
}

class BkashIconState extends State<BkashIcon>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppIcons.pathToBkashIcon,
      width: 40,
      color: context.theme.colorScheme.onPrimary,
    );
  }
}
