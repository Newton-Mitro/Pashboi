import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/app_theme.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';

part 'theme_selector_event.dart';
part 'theme_selector_state.dart';

enum ThemeName {
  primaryDark('primary_dark'),
  primaryLight('primary_light'),
  pinkLight('pink_light'),
  foreverGreenLight('forever_green');

  final String themeKey;
  const ThemeName(this.themeKey);

  static ThemeName fromKey(String key) {
    return ThemeName.values.firstWhere(
      (e) => e.themeKey == key,
      orElse: () => ThemeName.primaryLight,
    );
  }
}

class ThemeSelectorBloc extends Bloc<ThemeSelectorEvent, ThemeSelectorState> {
  final ThemeService themeService;

  ThemeSelectorBloc({required this.themeService})
    : super(PrimaryLightThemeState()) {
    on<LoadTheme>(_onLoadTheme);
    on<SetPrimaryLightTheme>(_onSetPrimaryLightTheme);
    on<SetPinkLightTheme>(_onSetPinkLightTheme);
    on<SetPrimaryDarkTheme>(_onSetPrimaryDarkTheme);
    on<SetForeverGreenLightTheme>(_onSetForeverGreenLightTheme);
  }

  Future<void> _onLoadTheme(
    LoadTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    final storedKey = await themeService.getTheme(); // string like 'dark'
    final theme = ThemeName.fromKey(storedKey);

    switch (theme) {
      case ThemeName.primaryDark:
        emit(PrimaryDarkThemeState());
        break;
      case ThemeName.foreverGreenLight:
        emit(ForeverGreenLightThemeState());
        break;
      case ThemeName.primaryLight:
        emit(PrimaryLightThemeState());
        break;
      case ThemeName.pinkLight:
        emit(PinkLightThemeState());
        break;
    }
  }

  Future<void> _onSetPrimaryLightTheme(
    SetPrimaryLightTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.primaryLight.themeKey);
    emit(PrimaryLightThemeState());
  }

  Future<void> _onSetPinkLightTheme(
    SetPinkLightTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.pinkLight.themeKey);
    emit(PinkLightThemeState());
  }

  Future<void> _onSetPrimaryDarkTheme(
    SetPrimaryDarkTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.primaryDark.themeKey);
    emit(PrimaryDarkThemeState());
  }

  Future<void> _onSetForeverGreenLightTheme(
    SetForeverGreenLightTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.foreverGreenLight.themeKey);
    emit(ForeverGreenLightThemeState());
  }
}
