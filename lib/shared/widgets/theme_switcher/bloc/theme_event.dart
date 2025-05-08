part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class LoadTheme extends ThemeEvent {}

class SetPrimaryLightTheme extends ThemeEvent {}

class SetPrimaryDarkTheme extends ThemeEvent {}

class SetForeverGreenLightTheme extends ThemeEvent {}
