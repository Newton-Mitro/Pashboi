import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/oliver_petal_colors.dart';

final _oliverPetalColors = OliverPetalColors();

ThemeData get oliverPetalThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _oliverPetalColors.background,

  colorScheme: ColorScheme.light(
    primary: _oliverPetalColors.primary,
    onPrimary: _oliverPetalColors.onPrimary,
    primaryContainer: _oliverPetalColors.primaryContainer,
    onPrimaryContainer: _oliverPetalColors.onPrimaryContainer,
    secondary: _oliverPetalColors.secondary,
    onSecondary: _oliverPetalColors.onSecondary,
    secondaryContainer: _oliverPetalColors.secondaryContainer,
    onSecondaryContainer: _oliverPetalColors.onSecondaryContainer,
    tertiary: _oliverPetalColors.tertiary,
    onTertiary: _oliverPetalColors.onTertiary,
    tertiaryContainer: _oliverPetalColors.tertiaryContainer,
    onTertiaryContainer: _oliverPetalColors.onTertiaryContainer,
    error: _oliverPetalColors.error,
    onError: _oliverPetalColors.onError,
    errorContainer: _oliverPetalColors.errorContainer,
    onErrorContainer: _oliverPetalColors.onErrorContainer,
    surface: _oliverPetalColors.surface,
    onSurface: _oliverPetalColors.onSurface,
    surfaceContainerHighest: _oliverPetalColors.surfaceContainer,
    onSurfaceVariant: _oliverPetalColors.onSurfaceVariant,
    outline: _oliverPetalColors.outline,
    shadow: _oliverPetalColors.shadow,
    inverseSurface: _oliverPetalColors.inverseSurface,
    onInverseSurface: _oliverPetalColors.onInverseSurface,
    inversePrimary: _oliverPetalColors.inversePrimary,
    surfaceTint: _oliverPetalColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _oliverPetalColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_oliverPetalColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _oliverPetalColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _oliverPetalColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_oliverPetalColors.primary),
    trackColor: WidgetStateProperty.all(_oliverPetalColors.onSurface),
  ),
  textTheme: _buildTextTheme(_oliverPetalColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _oliverPetalColors.onPrimary,
    ),
    backgroundColor: _oliverPetalColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _oliverPetalColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _oliverPetalColors.error,
    labelColor: _oliverPetalColors.selected,
    unselectedLabelColor: _oliverPetalColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _oliverPetalColors.primary,
    selectedItemColor: _oliverPetalColors.selected,
    unselectedItemColor: _oliverPetalColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _oliverPetalColors.secondary),
      ),
      backgroundColor: _oliverPetalColors.primary,
      foregroundColor: _oliverPetalColors.onPrimary,
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
