part of 'theme_selector_bloc.dart';

abstract class ThemeSelectorState {
  final ThemeData themeData;
  const ThemeSelectorState(this.themeData);
}

class BlueOceanTheme extends ThemeSelectorState {
  BlueOceanTheme() : super(AppTheme.blueOcean);
}

class EleganceTheme extends ThemeSelectorState {
  EleganceTheme() : super(AppTheme.elegance);
}

class DarkBlueAbyssTheme extends ThemeSelectorState {
  DarkBlueAbyssTheme() : super(AppTheme.darkBlueAbyss);
}

class OliverPetalTheme extends ThemeSelectorState {
  OliverPetalTheme() : super(AppTheme.oliverPetal);
}
