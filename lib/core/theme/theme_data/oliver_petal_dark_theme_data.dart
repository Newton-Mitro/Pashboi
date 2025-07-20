import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/animations/fade_slide_transition.dart';
import 'package:pashboi/core/theme/values/colors/oliver_petal_dark_colors.dart';

final _oliverPetalDarkColors = OliverPetalDarkColors();
ThemeData get oliverPetalDarkThemeData => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: _oliverPetalDarkColors.background,
  colorScheme: ColorScheme.dark(
    brightness: Brightness.dark,
    primary: _oliverPetalDarkColors.primary,
    onPrimary: _oliverPetalDarkColors.onPrimary,
    primaryContainer: _oliverPetalDarkColors.primaryContainer,
    onPrimaryContainer: _oliverPetalDarkColors.onPrimaryContainer,
    secondary: _oliverPetalDarkColors.secondary,
    onSecondary: _oliverPetalDarkColors.onSecondary,
    secondaryContainer: _oliverPetalDarkColors.secondaryContainer,
    onSecondaryContainer: _oliverPetalDarkColors.onSecondaryContainer,
    tertiary: _oliverPetalDarkColors.tertiary,
    onTertiary: _oliverPetalDarkColors.onTertiary,
    tertiaryContainer: _oliverPetalDarkColors.tertiaryContainer,
    onTertiaryContainer: _oliverPetalDarkColors.onTertiaryContainer,
    error: _oliverPetalDarkColors.error,
    onError: _oliverPetalDarkColors.onError,
    errorContainer: _oliverPetalDarkColors.errorContainer,
    onErrorContainer: _oliverPetalDarkColors.onErrorContainer,
    surface: _oliverPetalDarkColors.surface,
    onSurface: _oliverPetalDarkColors.onSurface,
    surfaceContainerHighest: _oliverPetalDarkColors.surfaceContainer,
    onSurfaceVariant: _oliverPetalDarkColors.onSurfaceVariant,
    outline: _oliverPetalDarkColors.outline,
    shadow: _oliverPetalDarkColors.shadow,
    inverseSurface: _oliverPetalDarkColors.inverseSurface,
    onInverseSurface: _oliverPetalDarkColors.onInverseSurface,
    inversePrimary: _oliverPetalDarkColors.inversePrimary,
    surfaceTint: _oliverPetalDarkColors.surfaceTint,
  ),
  popupMenuTheme: PopupMenuThemeData(color: _oliverPetalDarkColors.surface),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.all(_oliverPetalDarkColors.onPrimary),
  ),
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: _oliverPetalDarkColors.surface, // Background color
      borderRadius: BorderRadius.circular(8),
    ),
    textStyle: TextStyle(
      color: _oliverPetalDarkColors.onSurface, // Foreground (text) color
      fontSize: 14,
    ),
    waitDuration: Duration(milliseconds: 500),
    showDuration: Duration(seconds: 2),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.all(_oliverPetalDarkColors.primary),
    trackColor: WidgetStateProperty.all(_oliverPetalDarkColors.onSurface),
  ),
  textTheme: _buildTextTheme(_oliverPetalDarkColors.onSurface),
  fontFamily: 'Roboto',
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: _oliverPetalDarkColors.onPrimary,
    ),
    backgroundColor: _oliverPetalDarkColors.primary,
    elevation: 0,
    iconTheme: IconThemeData(color: _oliverPetalDarkColors.onPrimary),
  ),
  tabBarTheme: TabBarThemeData(
    indicatorColor: _oliverPetalDarkColors.error,
    labelColor: _oliverPetalDarkColors.selected,
    unselectedLabelColor: _oliverPetalDarkColors.unSelected,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _oliverPetalDarkColors.primary,
    selectedItemColor: _oliverPetalDarkColors.selected,
    unselectedItemColor: _oliverPetalDarkColors.unSelected,
  ),
  pageTransitionsTheme: _pageTransitionsTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // also slightly tighter curve
        side: BorderSide(color: _oliverPetalDarkColors.secondary),
      ),
      backgroundColor: _oliverPetalDarkColors.primary,
      foregroundColor: _oliverPetalDarkColors.onPrimary,
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
