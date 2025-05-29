import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/app_theme.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';

part 'theme_selector_event.dart';
part 'theme_selector_state.dart';

enum ThemeName {
  darkBlueAbyss('darkBlueAbyss'),
  blueOcean('blueOcean'),
  elegance('elegance'),
  oliverPetal('oliverPetal');

  final String themeKey;
  const ThemeName(this.themeKey);

  static ThemeName fromKey(String key) {
    return ThemeName.values.firstWhere(
      (e) => e.themeKey == key,
      orElse: () => ThemeName.blueOcean,
    );
  }
}

class ThemeSelectorBloc extends Bloc<ThemeSelectorEvent, ThemeSelectorState> {
  final ThemeService themeService;

  ThemeSelectorBloc({required this.themeService}) : super(BlueOceanTheme()) {
    on<LoadTheme>(_onLoadTheme);
    on<SetBlueOceanTheme>(_onSetPrimaryLightTheme);
    on<SetEleganceTheme>(_onSetPinkLightTheme);
    on<SetDarkBlueAbyssTheme>(_onSetPrimaryDarkTheme);
    on<SetOliverPetalTheme>(_onSetForeverGreenLightTheme);
  }

  Future<void> _onLoadTheme(
    LoadTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    final storedKey = await themeService.getTheme(); // string like 'dark'
    final theme = ThemeName.fromKey(storedKey);

    switch (theme) {
      case ThemeName.darkBlueAbyss:
        emit(DarkBlueAbyssTheme());
        break;
      case ThemeName.oliverPetal:
        emit(OliverPetalTheme());
        break;
      case ThemeName.blueOcean:
        emit(BlueOceanTheme());
        break;
      case ThemeName.elegance:
        emit(EleganceTheme());
        break;
    }
  }

  Future<void> _onSetPrimaryLightTheme(
    SetBlueOceanTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.blueOcean.themeKey);
    emit(BlueOceanTheme());
  }

  Future<void> _onSetPinkLightTheme(
    SetEleganceTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.elegance.themeKey);
    emit(EleganceTheme());
  }

  Future<void> _onSetPrimaryDarkTheme(
    SetDarkBlueAbyssTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.darkBlueAbyss.themeKey);
    emit(DarkBlueAbyssTheme());
  }

  Future<void> _onSetForeverGreenLightTheme(
    SetOliverPetalTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.oliverPetal.themeKey);
    emit(OliverPetalTheme());
  }
}
