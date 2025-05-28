part of 'theme_selector_bloc.dart';

abstract class ThemeSelectorState {
  final ThemeData themeData;
  const ThemeSelectorState(this.themeData);
}

class PrimaryLightThemeState extends ThemeSelectorState {
  PrimaryLightThemeState() : super(AppTheme.primaryLight);
}

class PinkLightThemeState extends ThemeSelectorState {
  PinkLightThemeState() : super(AppTheme.pinkLight);
}

class PrimaryDarkThemeState extends ThemeSelectorState {
  PrimaryDarkThemeState() : super(AppTheme.primaryDark);
}

class ForeverGreenLightThemeState extends ThemeSelectorState {
  ForeverGreenLightThemeState() : super(AppTheme.foreverGreenLight);
}
