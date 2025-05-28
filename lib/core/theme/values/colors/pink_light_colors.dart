import 'package:flutter/material.dart';
import 'app_colors.dart';

class PinkLightColors extends AppColors {
  static const Color _primary = Color(0xFFE91E63);

  @override
  Color get primary => _primary;

  @override
  Color get primaryVariant => const Color(0xFFC2185B); // Darker pink

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => const Color(0xFFF8BBD0); // Light pink

  @override
  Color get onPrimaryContainer => const Color(0xFF880E4F); // Dark text on pink

  @override
  Color get primaryFixed => _primary;

  @override
  Color get primaryFixedDim => const Color(0xFFD81B60);

  @override
  Color get onPrimaryFixed => Colors.white;

  @override
  Color get onPrimaryFixedVariant => Colors.white70;

  @override
  Color get secondary => const Color(0xFFFF4081); // Accent pink

  @override
  Color get secondaryVariant => const Color(0xFFF06292);

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => const Color(0xFFFCE4EC);

  @override
  Color get onSecondaryContainer => const Color(0xFF880E4F);

  @override
  Color get secondaryFixed => const Color(0xFFFF80AB);

  @override
  Color get secondaryFixedDim => const Color(0xFFEC407A);

  @override
  Color get onSecondaryFixed => Colors.white;

  @override
  Color get onSecondaryFixedVariant => Colors.white70;

  @override
  Color get tertiary => const Color(0xFFF48FB1); // soft pink tertiary

  @override
  Color get onTertiary => Colors.white;

  @override
  Color get tertiaryContainer => const Color(0xFFFCE4EC);

  @override
  Color get onTertiaryContainer => const Color(0xFF880E4F);

  @override
  Color get tertiaryFixed => const Color(0xFFF48FB1);

  @override
  Color get tertiaryFixedDim => const Color(0xFFF06292);

  @override
  Color get onTertiaryFixed => Colors.white;

  @override
  Color get onTertiaryFixedVariant => Colors.white70;

  @override
  Color get error => const Color(0xFFB00020);

  @override
  Color get onError => Colors.white;

  @override
  Color get errorContainer => const Color(0xFFFFDAD4);

  @override
  Color get onErrorContainer => const Color(0xFF410002);

  @override
  Color get background => const Color(0xFFFFF0F4); // light pink background

  @override
  Color get onBackground => const Color(0xFF1B1B1F);

  @override
  Color get surface => Colors.white;

  @override
  Color get onSurface => const Color(0xFF1B1B1F);

  @override
  Color get surfaceDim => const Color(0xFFF2F2F2);

  @override
  Color get surfaceBright => const Color(0xFFFFFFFF);

  @override
  Color get surfaceContainerLowest => const Color(0xFFFFFFFF);

  @override
  Color get surfaceContainerLow => const Color(0xFFF4F4F4);

  @override
  Color get surfaceContainer => const Color(0xFFEDEDED);

  @override
  Color get surfaceContainerHigh => const Color(0xFFE5E5E5);

  @override
  Color get surfaceContainerHighest => const Color(0xFFDADADA);

  @override
  Color get surfaceVariant => const Color(0xFFF8BBD0); // pink surface variant

  @override
  Color get onSurfaceVariant => const Color(0xFF49454F);

  @override
  Color get surfaceTint => _primary;

  @override
  Color get outline => const Color(0xFF7D7D7D);

  @override
  Color get outlineVariant => const Color(0xFFE1E1E1);

  @override
  Color get shadow => Colors.black12;

  @override
  Color get scrim => Colors.black38;

  @override
  Color get inverseSurface => const Color(0xFF2E2E2E);

  @override
  Color get onInverseSurface => Colors.white;

  @override
  Color get inversePrimary => const Color(0xFFFFC1E3); // light inverse pink

  @override
  Color get selected => _primary;

  @override
  Color get unSelected => const Color(0xFF1B1B1F).withOpacity(0.6);

  @override
  Color get disabled => const Color(0xFF1B1B1F).withOpacity(0.38);
}
