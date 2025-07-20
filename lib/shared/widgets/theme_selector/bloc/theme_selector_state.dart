part of 'theme_selector_bloc.dart';

abstract class ThemeSelectorState {
  final ThemeData themeData;
  const ThemeSelectorState(this.themeData);
}

class DarkAbyssTheme extends ThemeSelectorState {
  DarkAbyssTheme() : super(AppTheme.darkAbyss);
}

class BlueOceanTheme extends ThemeSelectorState {
  BlueOceanTheme() : super(AppTheme.blueOcean);
}

class BlueOceanDarkTheme extends ThemeSelectorState {
  BlueOceanDarkTheme() : super(AppTheme.blueOceanDark);
}

class EleganceTheme extends ThemeSelectorState {
  EleganceTheme() : super(AppTheme.elegance);
}

class EleganceDarkTheme extends ThemeSelectorState {
  EleganceDarkTheme() : super(AppTheme.eleganceDark);
}

class OliverPetalTheme extends ThemeSelectorState {
  OliverPetalTheme() : super(AppTheme.oliverPetal);
}

class OliverPetalDarkTheme extends ThemeSelectorState {
  OliverPetalDarkTheme() : super(AppTheme.oliverPetalDark);
}
