import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/elegance_dark_colors.dart';

final _eleganceDarkColors = EleganceDarkColors();
ThemeData get eleganceDarkThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _eleganceDarkColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _eleganceDarkColors.primary,
    onPrimary: _eleganceDarkColors.onPrimary,
    primaryContainer: _eleganceDarkColors.primaryContainer,
    onPrimaryContainer: _eleganceDarkColors.onPrimaryContainer,
    secondary: _eleganceDarkColors.secondary,
    onSecondary: _eleganceDarkColors.onSecondary,
    secondaryContainer: _eleganceDarkColors.secondaryContainer,
    onSecondaryContainer: _eleganceDarkColors.onSecondaryContainer,
    tertiary: _eleganceDarkColors.tertiary,
    onTertiary: _eleganceDarkColors.onTertiary,
    tertiaryContainer: _eleganceDarkColors.tertiaryContainer,
    onTertiaryContainer: _eleganceDarkColors.onTertiaryContainer,
    error: _eleganceDarkColors.error,
    onError: _eleganceDarkColors.onError,
    errorContainer: _eleganceDarkColors.errorContainer,
    onErrorContainer: _eleganceDarkColors.onErrorContainer,
    surface: _eleganceDarkColors.surface,
    onSurface: _eleganceDarkColors.onSurface,
    surfaceContainerHighest: _eleganceDarkColors.surfaceContainer,
    onSurfaceVariant: _eleganceDarkColors.onSurfaceVariant,
    outline: _eleganceDarkColors.outline,
    shadow: _eleganceDarkColors.shadow,
    inverseSurface: _eleganceDarkColors.inverseSurface,
    onInverseSurface: _eleganceDarkColors.onInverseSurface,
    inversePrimary: _eleganceDarkColors.inversePrimary,
    surfaceTint: _eleganceDarkColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _eleganceDarkColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_eleganceDarkColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _eleganceDarkColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _eleganceDarkColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_eleganceDarkColors.primary),
    trackColor: WidgetStateProperty.all(_eleganceDarkColors.onSurface),
  ),
  textTheme: _buildTextTheme(_eleganceDarkColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _eleganceDarkColors.onPrimary,
    ),
    backgroundColor: _eleganceDarkColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _eleganceDarkColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _eleganceDarkColors.error,
    labelColor: _eleganceDarkColors.selected,
    unselectedLabelColor: _eleganceDarkColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _eleganceDarkColors.primary,
    selectedItemColor: _eleganceDarkColors.selected,
    unselectedItemColor: _eleganceDarkColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _eleganceDarkColors.secondary),
      ),
      backgroundColor: _eleganceDarkColors.primary,
      foregroundColor: _eleganceDarkColors.onPrimary,
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
