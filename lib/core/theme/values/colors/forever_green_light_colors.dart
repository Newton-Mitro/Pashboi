import 'package:flutter/material.dart';
import 'app_colors.dart';

class ForeverGreenLightColor implements AppColors {
  // Primary colors
  @override
  Color get primary => const Color.fromARGB(255, 26, 124, 70);
  @override
  Color get primaryVariant => const Color(0xFF388E3C); // Dark Green
  @override
  Color get onPrimary => Colors.white; // White text on primary
  @override
  Color get primaryContainer => const Color(0xFFC8E6C9); // Light Green Container
  @override
  Color get onPrimaryContainer => const Color(0xFF004D40); // Dark Green on container
  @override
  Color get primaryFixed => const Color(0xFF66BB6A); // Same as primary
  @override
  Color get primaryFixedDim => const Color(0xFF388E3C); // Dimmed green
  @override
  Color get onPrimaryFixed => Colors.white; // White text on fixed primary
  @override
  Color get onPrimaryFixedVariant => const Color(0xFF004D40); // Dark Green on fixed variant

  // Secondary colors
  @override
  Color get secondary => const Color(0xFF81C784); // Light Green
  @override
  Color get secondaryVariant => const Color(0xFF4CAF50); // Green
  @override
  Color get onSecondary => Colors.white; // White text on secondary
  @override
  Color get secondaryContainer => const Color(0xFFDCE775); // Light Yellow-Green
  @override
  Color get onSecondaryContainer => const Color(0xFF33691E); // Dark Green text on container
  @override
  Color get secondaryFixed => const Color(0xFF81C784); // Same as secondary
  @override
  Color get secondaryFixedDim => const Color(0xFF4CAF50); // Dimmed green
  @override
  Color get onSecondaryFixed => Colors.white; // White text on fixed secondary
  @override
  Color get onSecondaryFixedVariant => const Color(0xFF33691E); // Dark Green text on fixed variant

  // Tertiary colors
  @override
  Color get tertiary => const Color(0xFF4CAF50); // Green
  @override
  Color get onTertiary => Colors.white; // White text on tertiary
  @override
  Color get tertiaryContainer => const Color(0xFFE8F5E9); // Light Green container
  @override
  Color get onTertiaryContainer => const Color(0xFF1B5E20); // Dark Green text on container
  @override
  Color get tertiaryFixed => const Color(0xFF4CAF50); // Same as tertiary
  @override
  Color get tertiaryFixedDim => const Color(0xFF388E3C); // Dimmed green
  @override
  Color get onTertiaryFixed => Colors.white; // White text on fixed tertiary
  @override
  Color get onTertiaryFixedVariant => const Color(0xFF1B5E20); // Dark Green on fixed variant

  // Error colors
  @override
  Color get error => const Color(0xFFD32F2F); // Red
  @override
  Color get onError => Colors.white; // White text on error
  @override
  Color get errorContainer => const Color(0xFFF8D7DA); // Light Red
  @override
  Color get onErrorContainer => const Color(0xFF9C1C1C); // Dark Red text

  // Background & Surface
  @override
  Color get background => const Color(0xFFF1F8E9); // Light Green background
  @override
  Color get onBackground => const Color(0xFF212121); // Dark text on background
  @override
  Color get surface => const Color(0xFFC8E6C9); // Light Green surface
  @override
  Color get onSurface => const Color(0xFF212121); // Dark text on surface
  @override
  Color get surfaceDim => const Color(0xFFE8F5E9); // Dimmed light green
  @override
  Color get surfaceBright => const Color(0xFFC8E6C9); // Bright surface
  @override
  Color get surfaceContainerLowest => const Color(0xFFDCE775); // Light Yellow-Green container
  @override
  Color get surfaceContainerLow => const Color(0xFFE8F5E9); // Soft green container
  @override
  Color get surfaceContainer => const Color(0xFFC8E6C9); // Standard surface container
  @override
  Color get surfaceContainerHigh => const Color(0xFFE8F5E9); // High contrast container
  @override
  Color get surfaceContainerHighest => const Color(0xFF4CAF50); // Green container
  @override
  Color get surfaceVariant => const Color(0xFFE8F5E9); // Soft green variant
  @override
  Color get onSurfaceVariant => const Color(0xFF212121); // Dark text on surface variant
  @override
  Color get surfaceTint => const Color(0xFF66BB6A); // Tint with primary color

  // Outline & Shadow
  @override
  Color get outline => const Color(0xFFBDBDBD); // Light outline
  @override
  Color get outlineVariant => const Color(0xFF9E9E9E); // Slightly darker outline
  @override
  Color get shadow => const Color(0xFF9E9E9E); // Soft shadow gray
  @override
  Color get scrim => const Color(0xFFE0E0E0); // Soft scrim overlay

  // Inverse Colors
  @override
  Color get inverseSurface => const Color(0xFF212121); // Dark surface inverse
  @override
  Color get onInverseSurface => const Color(0xFFFFFFFF); // Light text on inverse surface
  @override
  Color get inversePrimary => const Color(0xFF388E3C); // Dark Green inverse

  // Additional UI Colors
  @override
  Color get selected => const Color.fromARGB(255, 250, 253, 250); // Green for selected items
  @override
  Color get unSelected => const Color.fromARGB(255, 202, 250, 213); // Light gray for unselected
  @override
  Color get disabled => const Color(0xFFB0B0B0); // Disabled gray
}
