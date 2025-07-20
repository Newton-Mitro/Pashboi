import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/dark_blue_ocean_colors.dart';

final _blueOceanDarkColors = DarkBlueOceanColors();
ThemeData get blueOceanDarkThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _blueOceanDarkColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _blueOceanDarkColors.primary,
    onPrimary: _blueOceanDarkColors.onPrimary,
    primaryContainer: _blueOceanDarkColors.primaryContainer,
    onPrimaryContainer: _blueOceanDarkColors.onPrimaryContainer,
    secondary: _blueOceanDarkColors.secondary,
    onSecondary: _blueOceanDarkColors.onSecondary,
    secondaryContainer: _blueOceanDarkColors.secondaryContainer,
    onSecondaryContainer: _blueOceanDarkColors.onSecondaryContainer,
    tertiary: _blueOceanDarkColors.tertiary,
    onTertiary: _blueOceanDarkColors.onTertiary,
    tertiaryContainer: _blueOceanDarkColors.tertiaryContainer,
    onTertiaryContainer: _blueOceanDarkColors.onTertiaryContainer,
    error: _blueOceanDarkColors.error,
    onError: _blueOceanDarkColors.onError,
    errorContainer: _blueOceanDarkColors.errorContainer,
    onErrorContainer: _blueOceanDarkColors.onErrorContainer,
    surface: _blueOceanDarkColors.surface,
    onSurface: _blueOceanDarkColors.onSurface,
    surfaceContainerHighest: _blueOceanDarkColors.surfaceContainer,
    onSurfaceVariant: _blueOceanDarkColors.onSurfaceVariant,
    outline: _blueOceanDarkColors.outline,
    shadow: _blueOceanDarkColors.shadow,
    inverseSurface: _blueOceanDarkColors.inverseSurface,
    onInverseSurface: _blueOceanDarkColors.onInverseSurface,
    inversePrimary: _blueOceanDarkColors.inversePrimary,
    surfaceTint: _blueOceanDarkColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _blueOceanDarkColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_blueOceanDarkColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _blueOceanDarkColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _blueOceanDarkColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_blueOceanDarkColors.primary),
    trackColor: WidgetStateProperty.all(_blueOceanDarkColors.onSurface),
  ),
  textTheme: _buildTextTheme(_blueOceanDarkColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _blueOceanDarkColors.onPrimary,
    ),
    backgroundColor: _blueOceanDarkColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _blueOceanDarkColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _blueOceanDarkColors.error,
    labelColor: _blueOceanDarkColors.selected,
    unselectedLabelColor: _blueOceanDarkColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _blueOceanDarkColors.primary,
    selectedItemColor: _blueOceanDarkColors.selected,
    unselectedItemColor: _blueOceanDarkColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _blueOceanDarkColors.secondary),
      ),
      backgroundColor: _blueOceanDarkColors.primary,
      foregroundColor: _blueOceanDarkColors.onPrimary,
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
