import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/elegance_colors.dart';

final _pinkLightColors = EleganceColors();

ThemeData get eleganceThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _pinkLightColors.background,
  colorScheme: ColorScheme.light(
    primary: _pinkLightColors.primary,
    onPrimary: _pinkLightColors.onPrimary,
    primaryContainer: _pinkLightColors.primaryContainer,
    onPrimaryContainer: _pinkLightColors.onPrimaryContainer,
    secondary: _pinkLightColors.secondary,
    onSecondary: _pinkLightColors.onSecondary,
    secondaryContainer: _pinkLightColors.secondaryContainer,
    onSecondaryContainer: _pinkLightColors.onSecondaryContainer,
    tertiary: _pinkLightColors.tertiary,
    onTertiary: _pinkLightColors.onTertiary,
    tertiaryContainer: _pinkLightColors.tertiaryContainer,
    onTertiaryContainer: _pinkLightColors.onTertiaryContainer,
    error: _pinkLightColors.error,
    onError: _pinkLightColors.onError,
    errorContainer: _pinkLightColors.errorContainer,
    onErrorContainer: _pinkLightColors.onErrorContainer,
    surface: _pinkLightColors.surface,
    onSurface: _pinkLightColors.onSurface,
    surfaceContainerHighest: _pinkLightColors.surfaceContainer,
    onSurfaceVariant: _pinkLightColors.onSurfaceVariant,
    outline: _pinkLightColors.outline,
    shadow: _pinkLightColors.shadow,
    inverseSurface: _pinkLightColors.inverseSurface,
    onInverseSurface: _pinkLightColors.onInverseSurface,
    inversePrimary: _pinkLightColors.inversePrimary,
    surfaceTint: _pinkLightColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _pinkLightColors.surface),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _pinkLightColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _pinkLightColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_pinkLightColors.primary),
    trackColor: WidgetStateProperty.all(_pinkLightColors.onSurface),
  ),
  textTheme: _buildTextTheme(_pinkLightColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _pinkLightColors.onPrimary,
    ),
    backgroundColor: _pinkLightColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _pinkLightColors.onPrimary),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _pinkLightColors.primary,
    selectedItemColor: _pinkLightColors.selected,
    unselectedItemColor: _pinkLightColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _pinkLightColors.secondary),
      ),
      backgroundColor: _pinkLightColors.primary,
      foregroundColor: _pinkLightColors.onPrimary,
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
