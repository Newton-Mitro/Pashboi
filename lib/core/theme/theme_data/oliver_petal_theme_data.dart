import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/oliver_petal_colors.dart';

final _foreverGreenLightColors = OliverPetalColors();

ThemeData get oliverPetalThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _foreverGreenLightColors.background,

  colorScheme: ColorScheme.light(
    primary: _foreverGreenLightColors.primary,
    onPrimary: _foreverGreenLightColors.onPrimary,
    primaryContainer: _foreverGreenLightColors.primaryContainer,
    onPrimaryContainer: _foreverGreenLightColors.onPrimaryContainer,
    secondary: _foreverGreenLightColors.secondary,
    onSecondary: _foreverGreenLightColors.onSecondary,
    secondaryContainer: _foreverGreenLightColors.secondaryContainer,
    onSecondaryContainer: _foreverGreenLightColors.onSecondaryContainer,
    tertiary: _foreverGreenLightColors.tertiary,
    onTertiary: _foreverGreenLightColors.onTertiary,
    tertiaryContainer: _foreverGreenLightColors.tertiaryContainer,
    onTertiaryContainer: _foreverGreenLightColors.onTertiaryContainer,
    error: _foreverGreenLightColors.error,
    onError: _foreverGreenLightColors.onError,
    errorContainer: _foreverGreenLightColors.errorContainer,
    onErrorContainer: _foreverGreenLightColors.onErrorContainer,
    surface: _foreverGreenLightColors.surface,
    onSurface: _foreverGreenLightColors.onSurface,
    surfaceContainerHighest: _foreverGreenLightColors.surfaceContainer,
    onSurfaceVariant: _foreverGreenLightColors.onSurfaceVariant,
    outline: _foreverGreenLightColors.outline,
    shadow: _foreverGreenLightColors.shadow,
    inverseSurface: _foreverGreenLightColors.inverseSurface,
    onInverseSurface: _foreverGreenLightColors.onInverseSurface,
    inversePrimary: _foreverGreenLightColors.inversePrimary,
    surfaceTint: _foreverGreenLightColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _foreverGreenLightColors.surface),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _foreverGreenLightColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _foreverGreenLightColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_foreverGreenLightColors.primary),
    trackColor: WidgetStateProperty.all(_foreverGreenLightColors.onSurface),
  ),
  textTheme: _buildTextTheme(_foreverGreenLightColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _foreverGreenLightColors.onPrimary,
    ),
    backgroundColor: _foreverGreenLightColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _foreverGreenLightColors.onPrimary),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _foreverGreenLightColors.primary,
    selectedItemColor: _foreverGreenLightColors.selected,
    unselectedItemColor: _foreverGreenLightColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _foreverGreenLightColors.secondary),
      ),
      backgroundColor: _foreverGreenLightColors.primary,
      foregroundColor: _foreverGreenLightColors.onPrimary,
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
