import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/dark_blue_abyss_colors.dart';

final _primaryDarkColors = DarkBlueAbyssColors();
ThemeData get darkBlueAbyssThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _primaryDarkColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _primaryDarkColors.primary,
    onPrimary: _primaryDarkColors.onPrimary,
    primaryContainer: _primaryDarkColors.primaryContainer,
    onPrimaryContainer: _primaryDarkColors.onPrimaryContainer,
    secondary: _primaryDarkColors.secondary,
    onSecondary: _primaryDarkColors.onSecondary,
    secondaryContainer: _primaryDarkColors.secondaryContainer,
    onSecondaryContainer: _primaryDarkColors.onSecondaryContainer,
    tertiary: _primaryDarkColors.tertiary,
    onTertiary: _primaryDarkColors.onTertiary,
    tertiaryContainer: _primaryDarkColors.tertiaryContainer,
    onTertiaryContainer: _primaryDarkColors.onTertiaryContainer,
    error: _primaryDarkColors.error,
    onError: _primaryDarkColors.onError,
    errorContainer: _primaryDarkColors.errorContainer,
    onErrorContainer: _primaryDarkColors.onErrorContainer,
    surface: _primaryDarkColors.surface,
    onSurface: _primaryDarkColors.onSurface,
    surfaceContainerHighest: _primaryDarkColors.surfaceContainer,
    onSurfaceVariant: _primaryDarkColors.onSurfaceVariant,
    outline: _primaryDarkColors.outline,
    shadow: _primaryDarkColors.shadow,
    inverseSurface: _primaryDarkColors.inverseSurface,
    onInverseSurface: _primaryDarkColors.onInverseSurface,
    inversePrimary: _primaryDarkColors.inversePrimary,
    surfaceTint: _primaryDarkColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _primaryDarkColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_primaryDarkColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _primaryDarkColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _primaryDarkColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_primaryDarkColors.primary),
    trackColor: WidgetStateProperty.all(_primaryDarkColors.onSurface),
  ),
  textTheme: _buildTextTheme(_primaryDarkColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _primaryDarkColors.onPrimary,
    ),
    backgroundColor: _primaryDarkColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _primaryDarkColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _primaryDarkColors.error,
    labelColor: _primaryDarkColors.selected,
    unselectedLabelColor: _primaryDarkColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _primaryDarkColors.primary,
    selectedItemColor: _primaryDarkColors.selected,
    unselectedItemColor: _primaryDarkColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _primaryDarkColors.secondary),
      ),
      backgroundColor: _primaryDarkColors.primary,
      foregroundColor: _primaryDarkColors.onPrimary,
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
