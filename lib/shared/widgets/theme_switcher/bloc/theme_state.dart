part of 'theme_bloc.dart';

abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState(this.themeData);
}

class PrimaryLightThemeState extends ThemeState {
  PrimaryLightThemeState() : super(AppTheme.primaryLight);
}

class PrimaryDarkThemeState extends ThemeState {
  PrimaryDarkThemeState() : super(AppTheme.primaryDark);
}

class ForeverGreenLightThemeState extends ThemeState {
  ForeverGreenLightThemeState() : super(AppTheme.foreverGreenLight);
}
