import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pashboi/core/theme/app_theme.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeService themeService;

  ThemeBloc({required this.themeService}) : super(PrimaryLightThemeState()) {
    on<LoadTheme>(_onLoadTheme);
    on<SetPrimaryLightTheme>(_onSetPrimaryLightTheme);
    on<SetPrimaryDarkTheme>(_onSetPrimaryDarkTheme);
    on<SetForeverGreenLightTheme>(_onSetForeverGreenLightTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final theme = await themeService.getTheme();

    switch (theme) {
      case 'dark':
        emit(PrimaryDarkThemeState());
        break;
      case 'forever_green':
        emit(ForeverGreenLightThemeState());
        break;
      case 'light':
      default:
        emit(PrimaryLightThemeState());
        break;
    }
  }

  Future<void> _onSetPrimaryLightTheme(
    SetPrimaryLightTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await themeService.setTheme('light');
    emit(PrimaryLightThemeState());
  }

  Future<void> _onSetPrimaryDarkTheme(
    SetPrimaryDarkTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await themeService.setTheme('dark');
    emit(PrimaryDarkThemeState());
  }

  Future<void> _onSetForeverGreenLightTheme(
    SetForeverGreenLightTheme event,
    Emitter<ThemeState> emit,
  ) async {
    await themeService.setTheme('forever_green');
    emit(ForeverGreenLightThemeState());
  }
}
