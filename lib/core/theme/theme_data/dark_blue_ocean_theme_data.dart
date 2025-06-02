import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/dark_blue_ocean_colors.dart';

final _darkBlueOceanColors = DarkBlueOceanColors();
ThemeData get darkBlueOceanThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _darkBlueOceanColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _darkBlueOceanColors.primary,
    onPrimary: _darkBlueOceanColors.onPrimary,
    primaryContainer: _darkBlueOceanColors.primaryContainer,
    onPrimaryContainer: _darkBlueOceanColors.onPrimaryContainer,
    secondary: _darkBlueOceanColors.secondary,
    onSecondary: _darkBlueOceanColors.onSecondary,
    secondaryContainer: _darkBlueOceanColors.secondaryContainer,
    onSecondaryContainer: _darkBlueOceanColors.onSecondaryContainer,
    tertiary: _darkBlueOceanColors.tertiary,
    onTertiary: _darkBlueOceanColors.onTertiary,
    tertiaryContainer: _darkBlueOceanColors.tertiaryContainer,
    onTertiaryContainer: _darkBlueOceanColors.onTertiaryContainer,
    error: _darkBlueOceanColors.error,
    onError: _darkBlueOceanColors.onError,
    errorContainer: _darkBlueOceanColors.errorContainer,
    onErrorContainer: _darkBlueOceanColors.onErrorContainer,
    surface: _darkBlueOceanColors.surface,
    onSurface: _darkBlueOceanColors.onSurface,
    surfaceContainerHighest: _darkBlueOceanColors.surfaceContainer,
    onSurfaceVariant: _darkBlueOceanColors.onSurfaceVariant,
    outline: _darkBlueOceanColors.outline,
    shadow: _darkBlueOceanColors.shadow,
    inverseSurface: _darkBlueOceanColors.inverseSurface,
    onInverseSurface: _darkBlueOceanColors.onInverseSurface,
    inversePrimary: _darkBlueOceanColors.inversePrimary,
    surfaceTint: _darkBlueOceanColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _darkBlueOceanColors.surface),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _darkBlueOceanColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _darkBlueOceanColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_darkBlueOceanColors.primary),
    trackColor: WidgetStateProperty.all(_darkBlueOceanColors.onSurface),
  ),
  textTheme: _buildTextTheme(_darkBlueOceanColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _darkBlueOceanColors.onPrimary,
    ),
    backgroundColor: _darkBlueOceanColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _darkBlueOceanColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _darkBlueOceanColors.error,
    labelColor: _darkBlueOceanColors.selected,
    unselectedLabelColor: _darkBlueOceanColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _darkBlueOceanColors.primary,
    selectedItemColor: _darkBlueOceanColors.selected,
    unselectedItemColor: _darkBlueOceanColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _darkBlueOceanColors.secondary),
      ),
      backgroundColor: _darkBlueOceanColors.primary,
      foregroundColor: _darkBlueOceanColors.onPrimary,
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
