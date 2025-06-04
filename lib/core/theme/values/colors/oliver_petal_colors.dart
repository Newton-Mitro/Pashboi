import 'package:flutter/material.dart';
import 'app_colors.dart';

class OliverPetalColors implements AppColors {
  static const Color _primary = Color.fromARGB(255, 26, 124, 70); // #1A7C46

  @override
  Color get primary => _primary;

  @override
  Color get primaryVariant => Color(0xFF165F38); // darker green

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => Color(0xFFB8EBCD);

  @override
  Color get onPrimaryContainer => _primary;

  @override
  Color get primaryFixed => _primary;

  @override
  Color get primaryFixedDim => Color(0xFF388E63);

  @override
  Color get onPrimaryFixed => Colors.white;

  @override
  Color get onPrimaryFixedVariant => Colors.white70;

  @override
  Color get secondary => Color(0xFF4C8565); // complementary to green

  @override
  Color get secondaryVariant => Color(0xFF2E5B47);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => Color(0xFFC7EFD9);

  @override
  Color get onSecondaryContainer => Color(0xFF164D34);

  @override
  Color get secondaryFixed => Color(0xFF4C8565);

  @override
  Color get secondaryFixedDim => Color(0xFF3C6F55);

  @override
  Color get onSecondaryFixed => Colors.white;

  @override
  Color get onSecondaryFixedVariant => Colors.white70;

  @override
  Color get tertiary => Color.fromARGB(255, 205, 248, 210); // more vibrant green

  @override
  Color get onTertiary => Colors.white;

  @override
  Color get tertiaryContainer => Color(0xFFCCF5D5);

  @override
  Color get onTertiaryContainer => Color(0xFF1D5931);

  @override
  Color get tertiaryFixed => Color(0xFF65A86D);

  @override
  Color get tertiaryFixedDim => Color(0xFF51915A);

  @override
  Color get onTertiaryFixed => Colors.white;

  @override
  Color get onTertiaryFixedVariant => Colors.white70;

  @override
  Color get error => Color(0xFFB00020);

  @override
  Color get onError => Colors.white;

  @override
  Color get errorContainer => Color(0xFFFFDAD4);

  @override
  Color get onErrorContainer => Color(0xFF410002);

  @override
  Color get background => Color(0xFFF5FDF7);

  @override
  Color get onBackground => Color(0xFF1B1B1F);

  @override
  Color get surface => Colors.white;

  @override
  Color get onSurface => Color(0xFF1B1B1F);

  @override
  Color get surfaceDim => Color(0xFFF2F2F2);

  @override
  Color get surfaceBright => Color(0xFFFFFFFF);

  @override
  Color get surfaceContainerLowest => Color(0xFFFFFFFF);

  @override
  Color get surfaceContainerLow => Color(0xFFF4F4F4);

  @override
  Color get surfaceContainer => Color(0xFFEDEDED);

  @override
  Color get surfaceContainerHigh => Color(0xFFE5E5E5);

  @override
  Color get surfaceContainerHighest => Color(0xFFDADADA);

  @override
  Color get surfaceVariant => Color(0xFFE1EDE6); // pale green surface

  @override
  Color get onSurfaceVariant => Color(0xFF424E45);

  @override
  Color get surfaceTint => _primary;

  @override
  Color get outline => Color(0xFF7D8F83);

  @override
  Color get outlineVariant => Color(0xFFCBD9D0);

  @override
  Color get shadow => Colors.black12;

  @override
  Color get scrim => Colors.black38;

  @override
  Color get inverseSurface => Color(0xFF2E2E2E);

  @override
  Color get onInverseSurface => Colors.white;

  @override
  Color get inversePrimary => Color(0xFF7FD3A4); // lighter green

  @override
  Color get selected => Colors.white;

  @override
  Color get unSelected => const Color.fromARGB(160, 255, 255, 255);

  @override
  Color get disabled => const Color.fromARGB(144, 255, 255, 255);
}
