import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/primary_light_colors.dart';

final _primaryLightColors = PrimaryLightColors();

ThemeData get primaryLightTheme => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _primaryLightColors.background,
  colorScheme: ColorScheme.light(
    primary: _primaryLightColors.primary,
    onPrimary: _primaryLightColors.onPrimary,
    primaryContainer: _primaryLightColors.primaryContainer,
    onPrimaryContainer: _primaryLightColors.onPrimaryContainer,
    secondary: _primaryLightColors.secondary,
    onSecondary: _primaryLightColors.onSecondary,
    secondaryContainer: _primaryLightColors.secondaryContainer,
    onSecondaryContainer: _primaryLightColors.onSecondaryContainer,
    tertiary: _primaryLightColors.tertiary,
    onTertiary: _primaryLightColors.onTertiary,
    tertiaryContainer: _primaryLightColors.tertiaryContainer,
    onTertiaryContainer: _primaryLightColors.onTertiaryContainer,
    error: _primaryLightColors.error,
    onError: _primaryLightColors.onError,
    errorContainer: _primaryLightColors.errorContainer,
    onErrorContainer: _primaryLightColors.onErrorContainer,
    surface: _primaryLightColors.surface,
    onSurface: _primaryLightColors.onSurface,
    surfaceContainerHighest: _primaryLightColors.surfaceContainer,
    onSurfaceVariant: _primaryLightColors.onSurfaceVariant,
    outline: _primaryLightColors.outline,
    shadow: _primaryLightColors.shadow,
    inverseSurface: _primaryLightColors.inverseSurface,
    onInverseSurface: _primaryLightColors.onInverseSurface,
    inversePrimary: _primaryLightColors.inversePrimary,
    surfaceTint: _primaryLightColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _primaryLightColors.surface),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _primaryLightColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _primaryLightColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_primaryLightColors.primary),
    trackColor: WidgetStateProperty.all(_primaryLightColors.onSurface),
  ),
  textTheme: _buildTextTheme(_primaryLightColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _primaryLightColors.onPrimary,
    ),
    backgroundColor: _primaryLightColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _primaryLightColors.onPrimary),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _primaryLightColors.primary,
    selectedItemColor: _primaryLightColors.selected,
    unselectedItemColor: _primaryLightColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _primaryLightColors.secondary),
      ),
      backgroundColor: _primaryLightColors.primary,
      foregroundColor: _primaryLightColors.onPrimary,
      textStyle: const TextStyle(
        fontSize: 16, // slightly smaller text
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    ),
  ),
);

TextTheme _buildTextTheme(Color color) {
  return TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
      height: 1.5,
      color: color,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.4,
      color: color,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.3,
      height: 1.3,
      color: color,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      height: 1.4,
      color: color,
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.4,
      height: 1.3,
      color: color,
    ),
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.3,
      height: 1.2,
      color: color,
    ),
    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.8,
      height: 1.6,
      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.7,
      height: 1.5,
      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      height: 1.4,
      color: color,
    ),
  );
}

final PageTransitionsTheme _pageTransitionsTheme = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: FadeSlideTransitionBuilder(),
    TargetPlatform.iOS: FadeSlideTransitionBuilder(),
  },
);
