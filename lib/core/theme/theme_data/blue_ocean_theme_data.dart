import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/blue_ocean_colors.dart';

final _blueOceanColors = BlueOceanColors();

ThemeData get blueOceanThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _blueOceanColors.background,
  colorScheme: ColorScheme.light(
    primary: _blueOceanColors.primary,
    onPrimary: _blueOceanColors.onPrimary,
    primaryContainer: _blueOceanColors.primaryContainer,
    onPrimaryContainer: _blueOceanColors.onPrimaryContainer,
    secondary: _blueOceanColors.secondary,
    onSecondary: _blueOceanColors.onSecondary,
    secondaryContainer: _blueOceanColors.secondaryContainer,
    onSecondaryContainer: _blueOceanColors.onSecondaryContainer,
    tertiary: _blueOceanColors.tertiary,
    onTertiary: _blueOceanColors.onTertiary,
    tertiaryContainer: _blueOceanColors.tertiaryContainer,
    onTertiaryContainer: _blueOceanColors.onTertiaryContainer,
    error: _blueOceanColors.error,
    onError: _blueOceanColors.onError,
    errorContainer: _blueOceanColors.errorContainer,
    onErrorContainer: _blueOceanColors.onErrorContainer,
    surface: _blueOceanColors.surface,
    onSurface: _blueOceanColors.onSurface,
    surfaceContainerHighest: _blueOceanColors.surfaceContainer,
    onSurfaceVariant: _blueOceanColors.onSurfaceVariant,
    outline: _blueOceanColors.outline,
    shadow: _blueOceanColors.shadow,
    inverseSurface: _blueOceanColors.inverseSurface,
    onInverseSurface: _blueOceanColors.onInverseSurface,
    inversePrimary: _blueOceanColors.inversePrimary,
    surfaceTint: _blueOceanColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _blueOceanColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_blueOceanColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _blueOceanColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _blueOceanColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_blueOceanColors.primary),
    trackColor: WidgetStateProperty.all(_blueOceanColors.onSurface),
  ),
  textTheme: _buildTextTheme(_blueOceanColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _blueOceanColors.onPrimary,
    ),
    backgroundColor: _blueOceanColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _blueOceanColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _blueOceanColors.error,
    labelColor: _blueOceanColors.selected,
    unselectedLabelColor: _blueOceanColors.unSelected,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _blueOceanColors.primary,
    selectedItemColor: _blueOceanColors.selected,
    unselectedItemColor: _blueOceanColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _blueOceanColors.secondary),
      ),
      backgroundColor: _blueOceanColors.primary,
      foregroundColor: _blueOceanColors.onPrimary,
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
