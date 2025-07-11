import 'package:flutter/material.dart';
import 'app_colors.dart';

class OliverPetalColors implements AppColors {
  static const Color _primary = Color(0xFFA9D36D); // Your fresh green!

  @override
  Color get primary => _primary;

  @override
  Color get primaryVariant => const Color(0xFF7AA63C); // Darker green variant

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => const Color(0xFFD9EDBB); // Soft pastel green container

  @override
  Color get onPrimaryContainer => const Color(0xFF3E5B23); // Deep contrast text on container

  @override
  Color get primaryFixed => _primary;

  @override
  Color get primaryFixedDim => const Color(0xFF95C25F); // Slightly muted green

  @override
  Color get onPrimaryFixed => Colors.white;

  @override
  Color get onPrimaryFixedVariant => Colors.white70;

  @override
  Color get secondary => const Color(0xFF8BC34A); // Fresh leafy secondary

  @override
  Color get secondaryVariant => const Color(0xFF689F38); // Deeper green accent

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => const Color(0xFFE7F6D5); // Light leafy background

  @override
  Color get onSecondaryContainer => const Color(0xFF33691E); // Dark green text

  @override
  Color get secondaryFixed => const Color(0xFFB5E07C);

  @override
  Color get secondaryFixedDim => const Color(0xFFA0CC6A);

  @override
  Color get onSecondaryFixed => Colors.white;

  @override
  Color get onSecondaryFixedVariant => Colors.white70;

  @override
  Color get tertiary => const Color(0xFFB2FF59); // Bright lime tertiary

  @override
  Color get onTertiary => const Color(0xFF263238);

  @override
  Color get tertiaryContainer => const Color(0xFFF1F8E9);

  @override
  Color get onTertiaryContainer => const Color(0xFF33691E);

  @override
  Color get tertiaryFixed => const Color(0xFFC5E1A5);

  @override
  Color get tertiaryFixedDim => const Color(0xFFAED581);

  @override
  Color get onTertiaryFixed => const Color(0xFF263238);

  @override
  Color get onTertiaryFixedVariant => Colors.black54;

  @override
  Color get error => const Color(0xFFB00020);

  @override
  Color get onError => Colors.white;

  @override
  Color get errorContainer => const Color(0xFFFFDAD4);

  @override
  Color get onErrorContainer => const Color(0xFF410002);

  @override
  Color get background => const Color(0xFFF9FFF2); // Light minty background

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
  Color get surfaceVariant => const Color(0xFFD9EDBB); // Match container tone

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
  Color get inversePrimary => const Color(0xFFD9EDBB); // Light inverse green

  @override
  Color get selected => _primary;

  @override
  Color get unSelected => const Color.fromARGB(160, 255, 255, 255);

  @override
  Color get disabled => const Color.fromARGB(144, 255, 255, 255);
}
