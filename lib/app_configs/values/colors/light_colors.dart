import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/values/colors/app_colors.dart';

class AppColorsLight extends AppColors {
  // Primary colors
  @override
  Color get primary => const Color.fromARGB(255, 37, 77, 45); // UPDATED ✅
  @override
  Color get primaryVariant => const Color(0xFF255530); // Darker green shade
  @override
  Color get onPrimary => Colors.white; // White text on dark green looks better
  @override
  Color get primaryContainer => const Color(0xFFA9D6AD); // Soft green background
  @override
  Color get onPrimaryContainer => const Color(0xFF00210F); // Very dark green text
  @override
  Color get primaryFixed => const Color(0xFFC8E6C9); // Light green
  @override
  Color get primaryFixedDim => const Color(0xFF81C784); // Dimmed light green
  @override
  Color get onPrimaryFixed => Colors.black;
  @override
  Color get onPrimaryFixedVariant => const Color(0xFF1B5E20); // Deep green

  // Secondary colors (same)
  @override
  Color get secondary => Colors.green;
  @override
  Color get secondaryVariant => Colors.greenAccent;
  @override
  Color get onSecondary => Colors.black;
  @override
  Color get secondaryContainer => const Color(0xFFC8E6C9);
  @override
  Color get onSecondaryContainer => Colors.black;
  @override
  Color get secondaryFixed => const Color(0xFFA5D6A7);
  @override
  Color get secondaryFixedDim => const Color(0xFF81C784);
  @override
  Color get onSecondaryFixed => Colors.black;
  @override
  Color get onSecondaryFixedVariant => const Color(0xFF388E3C);

  // Tertiary colors (same)
  @override
  Color get tertiary => const Color(0xFFFFB300);
  @override
  Color get onTertiary => Colors.black;
  @override
  Color get tertiaryContainer => const Color(0xFFFFE082);
  @override
  Color get onTertiaryContainer => Colors.black;
  @override
  Color get tertiaryFixed => const Color(0xFFFFD54F);
  @override
  Color get tertiaryFixedDim => const Color(0xFFFFC107);
  @override
  Color get onTertiaryFixed => Colors.black;
  @override
  Color get onTertiaryFixedVariant => const Color(0xFFFFA000);

  // Error colors (same)
  @override
  Color get error => Colors.red;
  @override
  Color get onError => Colors.white;
  @override
  Color get errorContainer => const Color(0xFFFCE4EC);
  @override
  Color get onErrorContainer => Colors.black;

  // Background & Surface (same)
  @override
  Color get background => const Color(0xFFD7EEFA);
  @override
  Color get onBackground => Colors.black;
  @override
  Color get surface => Colors.grey[100]!;
  @override
  Color get onSurface => Colors.black;
  @override
  Color get surfaceDim => const Color(0xFFEEEEEE);
  @override
  Color get surfaceBright => const Color(0xFFFFFFFF);
  @override
  Color get surfaceContainerLowest => const Color(0xFFFAFAFA);
  @override
  Color get surfaceContainerLow => const Color(0xFFF5F5F5);
  @override
  Color get surfaceContainer => const Color(0xFFE0E0E0);
  @override
  Color get surfaceContainerHigh => const Color(0xFFBDBDBD);
  @override
  Color get surfaceContainerHighest => const Color(0xFF9E9E9E);
  @override
  Color get surfaceVariant => const Color(0xFFECEFF1);
  @override
  Color get onSurfaceVariant => const Color(0xFFECEFF1);
  @override
  Color get surfaceTint => primary; // ✅ still correct

  // Outline & Shadow (same)
  @override
  Color get outline => const Color(0xFF757575);
  @override
  Color get outlineVariant => const Color(0xFFBDBDBD);
  @override
  Color get shadow => Colors.black;
  @override
  Color get scrim => Colors.black.withOpacity(0.5);

  // Inverse Colors (optional to tweak)
  @override
  Color get inverseSurface => const Color(0xFF303030);
  @override
  Color get onInverseSurface => Colors.white;
  @override
  Color get inversePrimary => const Color(0xFF64B5F6); // optional to change later

  // Additional UI Colors (same)
  @override
  Color get selected => const Color(0xFF0277BD);
  @override
  Color get unSelected => const Color(0xFF7EA8BD);
  @override
  Color get disabled => Colors.grey[400]!;

  // Grayscale Material Color (same)
  @override
  MaterialColor get gray => const MaterialColor(50, {
    50: Color(0xFFFAFAFA),
    100: Color(0xFFF5F5F5),
    200: Color(0xFFEEEEEE),
    300: Color(0xFFE0E0E0),
    350: Color(0xFFD6D6D6),
    400: Color(0xFFBDBDBD),
    500: Color(0xFF9E9E9E),
    600: Color(0xFF757575),
    700: Color(0xFF616161),
    800: Color(0xFF424242),
    850: Color(0xFF303030),
    900: Color(0xFF212121),
  });
}
