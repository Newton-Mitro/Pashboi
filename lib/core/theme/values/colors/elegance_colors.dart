import 'package:flutter/material.dart';
import 'app_colors.dart';

class EleganceColors extends AppColors {
  static const Color _primary = Color(0xFFCC04CC); // Your bold purple!

  @override
  Color get primary => _primary;

  @override
  Color get primaryVariant => const Color(0xFF990199); // Darker tone of your purple

  @override
  Color get onPrimary => Colors.white;

  @override
  Color get primaryContainer => const Color(0xFFF0B3F0); // Soft lavender container

  @override
  Color get onPrimaryContainer => const Color(0xFF4A004A); // Deep text on soft background

  @override
  Color get primaryFixed => _primary;

  @override
  Color get primaryFixedDim => const Color(0xFFD24AD2); // Slightly muted neon purple

  @override
  Color get onPrimaryFixed => Colors.white;

  @override
  Color get onPrimaryFixedVariant => Colors.white70;

  @override
  Color get secondary => const Color(0xFFE040FB); // Bright purple-pink secondary

  @override
  Color get secondaryVariant => const Color(0xFFBA68C8); // Softer violet

  @override
  Color get onSecondary => Colors.white;

  @override
  Color get secondaryContainer => const Color(0xFFF8EAF6); // Light purple background

  @override
  Color get onSecondaryContainer => const Color(0xFF4A148C); // Dark purple text

  @override
  Color get secondaryFixed => const Color(0xFFE1BEE7);

  @override
  Color get secondaryFixedDim => const Color(0xFFCE93D8);

  @override
  Color get onSecondaryFixed => Colors.white;

  @override
  Color get onSecondaryFixedVariant => Colors.white70;

  @override
  Color get tertiary => const Color(0xFFF500F5); // Neon pink-purple tertiary

  @override
  Color get onTertiary => Colors.white;

  @override
  Color get tertiaryContainer => const Color(0xFFFCE4EC);

  @override
  Color get onTertiaryContainer => const Color(0xFF6A1B9A);

  @override
  Color get tertiaryFixed => const Color(0xFFF48FB1);

  @override
  Color get tertiaryFixedDim => const Color(0xFFCE93D8);

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
  Color get background => const Color(0xFFFFF0FF); // Ultra-light pink-purple background

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
  Color get surfaceVariant => const Color(0xFFF0B3F0); // Matches container tones

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
  Color get inversePrimary => const Color(0xFFF8B0F8); // Light inverse purple

  @override
  Color get selected => _primary;

  @override
  Color get unSelected => const Color.fromARGB(160, 255, 255, 255);

  @override
  Color get disabled => const Color.fromARGB(144, 255, 255, 255);
}
