import 'package:flutter/material.dart';
import 'package:pashboi/core/animations/fade_slide_transition.dart';
import 'package:pashboi/core/values/colors/dark_colors.dart';
import 'package:pashboi/core/values/colors/light_colors.dart';

class AppTheme {
  final _darkColors = AppColorsDark();
  final _lightColors = AppColorsLight();

  ThemeData get dark => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkColors.background,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: _darkColors.primary,
      onPrimary: _darkColors.onPrimary,
      primaryContainer: _darkColors.primaryContainer,
      onPrimaryContainer: _darkColors.onPrimaryContainer,
      secondary: _darkColors.secondary,
      onSecondary: _darkColors.onSecondary,
      secondaryContainer: _darkColors.secondaryContainer,
      onSecondaryContainer: _darkColors.onSecondaryContainer,
      tertiary: _darkColors.tertiary,
      onTertiary: _darkColors.onTertiary,
      tertiaryContainer: _darkColors.tertiaryContainer,
      onTertiaryContainer: _darkColors.onTertiaryContainer,
      error: _darkColors.error,
      onError: _darkColors.onError,
      errorContainer: _darkColors.errorContainer,
      onErrorContainer: _darkColors.onErrorContainer,
      surface: _darkColors.surface,
      onSurface: _darkColors.onSurface,
      surfaceContainerHighest: _darkColors.surfaceContainer,
      onSurfaceVariant: _darkColors.onSurfaceVariant,
      outline: _darkColors.outline,
      shadow: _darkColors.shadow,
      inverseSurface: _darkColors.inverseSurface,
      onInverseSurface: _darkColors.onInverseSurface,
      inversePrimary: _darkColors.inversePrimary,
      surfaceTint: _darkColors.surfaceTint,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkColors.surface),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _darkColors.surface, // Background color
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: _darkColors.onSurface, // Foreground (text) color
        fontSize: 14,
      ),
      waitDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_darkColors.primary),
      trackColor: WidgetStateProperty.all(_darkColors.onSurface),
    ),
    textTheme: _buildTextTheme(_darkColors.onSurface),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: _darkColors.onPrimary),
      backgroundColor: _darkColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: _darkColors.onPrimary),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: _darkColors.error,
      labelColor: _darkColors.selected,
      unselectedLabelColor: _darkColors.unSelected,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkColors.primary,
      selectedItemColor: _darkColors.selected,
      unselectedItemColor: _darkColors.unSelected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // also slightly tighter curve
          side: BorderSide(color: _darkColors.secondary),
        ),
        backgroundColor: _darkColors.primary,
        foregroundColor: _darkColors.onPrimary,
        textStyle: const TextStyle(
          fontSize: 16, // slightly smaller text
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );

  ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _lightColors.background,
    colorScheme: ColorScheme.light(
      primary: _lightColors.primary,
      onPrimary: _lightColors.onPrimary,
      primaryContainer: _lightColors.primaryContainer,
      onPrimaryContainer: _lightColors.onPrimaryContainer,
      secondary: _lightColors.secondary,
      onSecondary: _lightColors.onSecondary,
      secondaryContainer: _lightColors.secondaryContainer,
      onSecondaryContainer: _lightColors.onSecondaryContainer,
      tertiary: _lightColors.tertiary,
      onTertiary: _lightColors.onTertiary,
      tertiaryContainer: _lightColors.tertiaryContainer,
      onTertiaryContainer: _lightColors.onTertiaryContainer,
      error: _lightColors.error,
      onError: _lightColors.onError,
      errorContainer: _lightColors.errorContainer,
      onErrorContainer: _lightColors.onErrorContainer,
      surface: _lightColors.surface,
      onSurface: _lightColors.onSurface,
      surfaceContainerHighest: _lightColors.surfaceContainer,
      onSurfaceVariant: _lightColors.onSurfaceVariant,
      outline: _lightColors.outline,
      shadow: _lightColors.shadow,
      inverseSurface: _lightColors.inverseSurface,
      onInverseSurface: _lightColors.onInverseSurface,
      inversePrimary: _lightColors.inversePrimary,
      surfaceTint: _lightColors.surfaceTint,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightColors.surface),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _lightColors.surface, // Background color
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: _lightColors.onSurface, // Foreground (text) color
        fontSize: 14,
      ),
      waitDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_lightColors.primary),
      trackColor: WidgetStateProperty.all(_lightColors.onSurface),
    ),
    textTheme: _buildTextTheme(_lightColors.onSurface),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontSize: 18, color: _lightColors.onPrimary),
      backgroundColor: _lightColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightColors.onPrimary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightColors.primary,
      selectedItemColor: _lightColors.selected,
      unselectedItemColor: _lightColors.unSelected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // also slightly tighter curve
          side: BorderSide(color: _lightColors.secondary),
        ),
        backgroundColor: _lightColors.primary,
        foregroundColor: _lightColors.onPrimary,
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
}
