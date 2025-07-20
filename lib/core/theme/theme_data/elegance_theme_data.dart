import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/elegance_colors.dart';

final _eleganceColors = EleganceColors();

ThemeData get eleganceThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _eleganceColors.background,
  colorScheme: ColorScheme.light(
    primary: _eleganceColors.primary,
    onPrimary: _eleganceColors.onPrimary,
    primaryContainer: _eleganceColors.primaryContainer,
    onPrimaryContainer: _eleganceColors.onPrimaryContainer,
    secondary: _eleganceColors.secondary,
    onSecondary: _eleganceColors.onSecondary,
    secondaryContainer: _eleganceColors.secondaryContainer,
    onSecondaryContainer: _eleganceColors.onSecondaryContainer,
    tertiary: _eleganceColors.tertiary,
    onTertiary: _eleganceColors.onTertiary,
    tertiaryContainer: _eleganceColors.tertiaryContainer,
    onTertiaryContainer: _eleganceColors.onTertiaryContainer,
    error: _eleganceColors.error,
    onError: _eleganceColors.onError,
    errorContainer: _eleganceColors.errorContainer,
    onErrorContainer: _eleganceColors.onErrorContainer,
    surface: _eleganceColors.surface,
    onSurface: _eleganceColors.onSurface,
    surfaceContainerHighest: _eleganceColors.surfaceContainer,
    onSurfaceVariant: _eleganceColors.onSurfaceVariant,
    outline: _eleganceColors.outline,
    shadow: _eleganceColors.shadow,
    inverseSurface: _eleganceColors.inverseSurface,
    onInverseSurface: _eleganceColors.onInverseSurface,
    inversePrimary: _eleganceColors.inversePrimary,
    surfaceTint: _eleganceColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _eleganceColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_eleganceColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _eleganceColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _eleganceColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_eleganceColors.primary),
    trackColor: WidgetStateProperty.all(_eleganceColors.onSurface),
  ),
  textTheme: _buildTextTheme(_eleganceColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _eleganceColors.onPrimary,
    ),
    backgroundColor: _eleganceColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _eleganceColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _eleganceColors.error,
    labelColor: _eleganceColors.selected,
    unselectedLabelColor: _eleganceColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _eleganceColors.primary,
    selectedItemColor: _eleganceColors.selected,
    unselectedItemColor: _eleganceColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _eleganceColors.secondary),
      ),
      backgroundColor: _eleganceColors.primary,
      foregroundColor: _eleganceColors.onPrimary,
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
