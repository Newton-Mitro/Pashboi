import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/dark_abyss_colors.dart';

final _darkAbyssColors = DarkAbyssColors();
ThemeData get darkAbyssThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _darkAbyssColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _darkAbyssColors.primary,
    onPrimary: _darkAbyssColors.onPrimary,
    primaryContainer: _darkAbyssColors.primaryContainer,
    onPrimaryContainer: _darkAbyssColors.onPrimaryContainer,
    secondary: _darkAbyssColors.secondary,
    onSecondary: _darkAbyssColors.onSecondary,
    secondaryContainer: _darkAbyssColors.secondaryContainer,
    onSecondaryContainer: _darkAbyssColors.onSecondaryContainer,
    tertiary: _darkAbyssColors.tertiary,
    onTertiary: _darkAbyssColors.onTertiary,
    tertiaryContainer: _darkAbyssColors.tertiaryContainer,
    onTertiaryContainer: _darkAbyssColors.onTertiaryContainer,
    error: _darkAbyssColors.error,
    onError: _darkAbyssColors.onError,
    errorContainer: _darkAbyssColors.errorContainer,
    onErrorContainer: _darkAbyssColors.onErrorContainer,
    surface: _darkAbyssColors.surface,
    onSurface: _darkAbyssColors.onSurface,
    surfaceContainerHighest: _darkAbyssColors.surfaceContainer,
    onSurfaceVariant: _darkAbyssColors.onSurfaceVariant,
    outline: _darkAbyssColors.outline,
    shadow: _darkAbyssColors.shadow,
    inverseSurface: _darkAbyssColors.inverseSurface,
    onInverseSurface: _darkAbyssColors.onInverseSurface,
    inversePrimary: _darkAbyssColors.inversePrimary,
    surfaceTint: _darkAbyssColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _darkAbyssColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_darkAbyssColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _darkAbyssColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _darkAbyssColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_darkAbyssColors.primary),
    trackColor: WidgetStateProperty.all(_darkAbyssColors.onSurface),
  ),
  textTheme: _buildTextTheme(_darkAbyssColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _darkAbyssColors.onPrimary,
    ),
    backgroundColor: _darkAbyssColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _darkAbyssColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _darkAbyssColors.error,
    labelColor: _darkAbyssColors.selected,
    unselectedLabelColor: _darkAbyssColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _darkAbyssColors.primary,
    selectedItemColor: _darkAbyssColors.selected,
    unselectedItemColor: _darkAbyssColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _darkAbyssColors.secondary),
      ),
      backgroundColor: _darkAbyssColors.primary,
      foregroundColor: _darkAbyssColors.onPrimary,
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
