import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/app_theme.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';

part 'theme_selector_event.dart';
part 'theme_selector_state.dart';

enum ThemeName {
  darkAbyss('darkAbyss'),
  blueOcean('blueOcean'),
  blueOceanDark('blueOceanDark'),
  elegance('elegance'),
  eleganceDark('eleganceDark'),
  oliverPetal('oliverPetal'),
  oliverPetalDark('oliverPetalDark');

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

    on<SetDarkAbyssTheme>(_setDarkAbyssTheme);

    on<SetBlueOceanTheme>(_setBlueOceanTheme);
    on<SetBlueOceanDarkTheme>(_onSetBlueOceanDarkTheme);

    on<SetEleganceTheme>(_setEleganceTheme);
    on<SetEleganceDarkTheme>(_setEleganceDarkTheme);

    on<SetOliverPetalTheme>(_setOliverPetalTheme);
    on<SetOliverPetalDarkTheme>(_setOliverPetalDarkTheme);
  }

  Future<void> _onLoadTheme(
    LoadTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    final storedKey = await themeService.getTheme(); // string like 'dark'
    final theme = ThemeName.fromKey(storedKey);

    switch (theme) {
      case ThemeName.darkAbyss:
        emit(DarkAbyssTheme());
        break;

      case ThemeName.blueOcean:
        emit(BlueOceanTheme());
        break;
      case ThemeName.blueOceanDark:
        emit(BlueOceanDarkTheme());
        break;

      case ThemeName.oliverPetal:
        emit(OliverPetalTheme());
        break;
      case ThemeName.oliverPetalDark:
        emit(OliverPetalDarkTheme());
        break;

      case ThemeName.elegance:
        emit(EleganceTheme());
        break;
      case ThemeName.eleganceDark:
        emit(EleganceDarkTheme());
        break;
    }
  }

  Future<void> _setDarkAbyssTheme(
    SetDarkAbyssTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.darkAbyss.themeKey);
    emit(DarkAbyssTheme());
  }

  Future<void> _setBlueOceanTheme(
    SetBlueOceanTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.blueOcean.themeKey);
    emit(BlueOceanTheme());
  }

  Future<void> _onSetBlueOceanDarkTheme(
    SetBlueOceanDarkTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.blueOceanDark.themeKey);
    emit(BlueOceanDarkTheme());
  }

  Future<void> _setEleganceTheme(
    SetEleganceTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.elegance.themeKey);
    emit(EleganceTheme());
  }

  Future<void> _setEleganceDarkTheme(
    SetEleganceDarkTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.eleganceDark.themeKey);
    emit(EleganceDarkTheme());
  }

  Future<void> _setOliverPetalTheme(
    SetOliverPetalTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.oliverPetal.themeKey);
    emit(OliverPetalTheme());
  }

  Future<void> _setOliverPetalDarkTheme(
    SetOliverPetalDarkTheme event,
    Emitter<ThemeSelectorState> emit,
  ) async {
    await themeService.setTheme(ThemeName.oliverPetalDark.themeKey);
    emit(OliverPetalDarkTheme());
  }
}
