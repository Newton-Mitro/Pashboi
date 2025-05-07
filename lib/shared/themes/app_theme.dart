import 'package:flutter/material.dart';
import 'package:pashboi/shared/animations/fade_slide_transition.dart';
import 'package:pashboi/shared/values/colors/app_colors_green_light.dart';
import 'package:pashboi/shared/values/colors/app_colors_primary_dark.dart';
import 'package:pashboi/shared/values/colors/app_colors_primary_light.dart';

class AppTheme {
  final _darkPrimaryColors = AppColorsPrimaryDark();
  final _lightPrimaryColors = AppColorsPrimaryLight();
  final _lightGreenColors = AppColorsGreenLight();

  ThemeData get darkPrimary => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _darkPrimaryColors.background,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: _darkPrimaryColors.primary,
      onPrimary: _darkPrimaryColors.onPrimary,
      primaryContainer: _darkPrimaryColors.primaryContainer,
      onPrimaryContainer: _darkPrimaryColors.onPrimaryContainer,
      secondary: _darkPrimaryColors.secondary,
      onSecondary: _darkPrimaryColors.onSecondary,
      secondaryContainer: _darkPrimaryColors.secondaryContainer,
      onSecondaryContainer: _darkPrimaryColors.onSecondaryContainer,
      tertiary: _darkPrimaryColors.tertiary,
      onTertiary: _darkPrimaryColors.onTertiary,
      tertiaryContainer: _darkPrimaryColors.tertiaryContainer,
      onTertiaryContainer: _darkPrimaryColors.onTertiaryContainer,
      error: _darkPrimaryColors.error,
      onError: _darkPrimaryColors.onError,
      errorContainer: _darkPrimaryColors.errorContainer,
      onErrorContainer: _darkPrimaryColors.onErrorContainer,
      surface: _darkPrimaryColors.surface,
      onSurface: _darkPrimaryColors.onSurface,
      surfaceContainerHighest: _darkPrimaryColors.surfaceContainer,
      onSurfaceVariant: _darkPrimaryColors.onSurfaceVariant,
      outline: _darkPrimaryColors.outline,
      shadow: _darkPrimaryColors.shadow,
      inverseSurface: _darkPrimaryColors.inverseSurface,
      onInverseSurface: _darkPrimaryColors.onInverseSurface,
      inversePrimary: _darkPrimaryColors.inversePrimary,
      surfaceTint: _darkPrimaryColors.surfaceTint,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkPrimaryColors.surface),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _darkPrimaryColors.surface, // Background color
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: _darkPrimaryColors.onSurface, // Foreground (text) color
        fontSize: 14,
      ),
      waitDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_darkPrimaryColors.primary),
      trackColor: WidgetStateProperty.all(_darkPrimaryColors.onSurface),
    ),
    textTheme: _buildTextTheme(_darkPrimaryColors.onSurface),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: _darkPrimaryColors.onPrimary,
      ),
      backgroundColor: _darkPrimaryColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: _darkPrimaryColors.onPrimary),
    ),
    tabBarTheme: TabBarTheme(
      indicatorColor: _darkPrimaryColors.error,
      labelColor: _darkPrimaryColors.selected,
      unselectedLabelColor: _darkPrimaryColors.unSelected,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkPrimaryColors.primary,
      selectedItemColor: _darkPrimaryColors.selected,
      unselectedItemColor: _darkPrimaryColors.unSelected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // also slightly tighter curve
          side: BorderSide(color: _darkPrimaryColors.secondary),
        ),
        backgroundColor: _darkPrimaryColors.primary,
        foregroundColor: _darkPrimaryColors.onPrimary,
        textStyle: const TextStyle(
          fontSize: 16, // slightly smaller text
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );

  ThemeData get lightPrimary => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _lightPrimaryColors.background,
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColors.primary,
      onPrimary: _lightPrimaryColors.onPrimary,
      primaryContainer: _lightPrimaryColors.primaryContainer,
      onPrimaryContainer: _lightPrimaryColors.onPrimaryContainer,
      secondary: _lightPrimaryColors.secondary,
      onSecondary: _lightPrimaryColors.onSecondary,
      secondaryContainer: _lightPrimaryColors.secondaryContainer,
      onSecondaryContainer: _lightPrimaryColors.onSecondaryContainer,
      tertiary: _lightPrimaryColors.tertiary,
      onTertiary: _lightPrimaryColors.onTertiary,
      tertiaryContainer: _lightPrimaryColors.tertiaryContainer,
      onTertiaryContainer: _lightPrimaryColors.onTertiaryContainer,
      error: _lightPrimaryColors.error,
      onError: _lightPrimaryColors.onError,
      errorContainer: _lightPrimaryColors.errorContainer,
      onErrorContainer: _lightPrimaryColors.onErrorContainer,
      surface: _lightPrimaryColors.surface,
      onSurface: _lightPrimaryColors.onSurface,
      surfaceContainerHighest: _lightPrimaryColors.surfaceContainer,
      onSurfaceVariant: _lightPrimaryColors.onSurfaceVariant,
      outline: _lightPrimaryColors.outline,
      shadow: _lightPrimaryColors.shadow,
      inverseSurface: _lightPrimaryColors.inverseSurface,
      onInverseSurface: _lightPrimaryColors.onInverseSurface,
      inversePrimary: _lightPrimaryColors.inversePrimary,
      surfaceTint: _lightPrimaryColors.surfaceTint,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightPrimaryColors.surface),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _lightPrimaryColors.surface, // Background color
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: _lightPrimaryColors.onSurface, // Foreground (text) color
        fontSize: 14,
      ),
      waitDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_lightPrimaryColors.primary),
      trackColor: WidgetStateProperty.all(_lightPrimaryColors.onSurface),
    ),
    textTheme: _buildTextTheme(_lightPrimaryColors.onSurface),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: _lightPrimaryColors.onPrimary,
      ),
      backgroundColor: _lightPrimaryColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightPrimaryColors.onPrimary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightPrimaryColors.primary,
      selectedItemColor: _lightPrimaryColors.selected,
      unselectedItemColor: _lightPrimaryColors.unSelected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // also slightly tighter curve
          side: BorderSide(color: _lightPrimaryColors.secondary),
        ),
        backgroundColor: _lightPrimaryColors.primary,
        foregroundColor: _lightPrimaryColors.onPrimary,
        textStyle: const TextStyle(
          fontSize: 16, // slightly smaller text
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  );

  ThemeData get lightGreen => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _lightGreenColors.background,
    colorScheme: ColorScheme.light(
      primary: _lightGreenColors.primary,
      onPrimary: _lightGreenColors.onPrimary,
      primaryContainer: _lightGreenColors.primaryContainer,
      onPrimaryContainer: _lightGreenColors.onPrimaryContainer,
      secondary: _lightGreenColors.secondary,
      onSecondary: _lightGreenColors.onSecondary,
      secondaryContainer: _lightGreenColors.secondaryContainer,
      onSecondaryContainer: _lightGreenColors.onSecondaryContainer,
      tertiary: _lightGreenColors.tertiary,
      onTertiary: _lightGreenColors.onTertiary,
      tertiaryContainer: _lightGreenColors.tertiaryContainer,
      onTertiaryContainer: _lightGreenColors.onTertiaryContainer,
      error: _lightGreenColors.error,
      onError: _lightGreenColors.onError,
      errorContainer: _lightGreenColors.errorContainer,
      onErrorContainer: _lightGreenColors.onErrorContainer,
      surface: _lightGreenColors.surface,
      onSurface: _lightGreenColors.onSurface,
      surfaceContainerHighest: _lightGreenColors.surfaceContainer,
      onSurfaceVariant: _lightGreenColors.onSurfaceVariant,
      outline: _lightGreenColors.outline,
      shadow: _lightGreenColors.shadow,
      inverseSurface: _lightGreenColors.inverseSurface,
      onInverseSurface: _lightGreenColors.onInverseSurface,
      inversePrimary: _lightGreenColors.inversePrimary,
      surfaceTint: _lightGreenColors.surfaceTint,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightGreenColors.surface),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: _lightGreenColors.surface, // Background color
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: TextStyle(
        color: _lightGreenColors.onSurface, // Foreground (text) color
        fontSize: 14,
      ),
      waitDuration: Duration(milliseconds: 500),
      showDuration: Duration(seconds: 2),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(_lightGreenColors.primary),
      trackColor: WidgetStateProperty.all(_lightGreenColors.onSurface),
    ),
    textTheme: _buildTextTheme(_lightGreenColors.onSurface),
    fontFamily: 'Roboto',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: _lightGreenColors.onPrimary,
      ),
      backgroundColor: _lightGreenColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(color: _lightGreenColors.onPrimary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _lightGreenColors.primary,
      selectedItemColor: _lightGreenColors.selected,
      unselectedItemColor: _lightGreenColors.unSelected,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ), // also slightly tighter curve
          side: BorderSide(color: _lightGreenColors.secondary),
        ),
        backgroundColor: _lightGreenColors.primary,
        foregroundColor: _lightGreenColors.onPrimary,
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
