import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pashboi/shared/widgets/theme_switcher/services/theme_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeService themeService;
  ThemeBloc({required this.themeService}) : super(LightThemeState()) {
    on<LoadThemeEvent>(_loadTheme);
    on<ToggleThemeEvent>(_toggleTheme);
  }

  // This method handles the loading of the theme
  Future<void> _loadTheme(
    LoadThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final theme = await themeService.getTheme();
    emit(theme == 'light' ? LightThemeState() : DarkThemeState());
  }

  // This method handles theme toggling
  Future<void> _toggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) async {
    final newState =
        state is LightThemeState
            ? const DarkThemeState()
            : const LightThemeState();

    await themeService.setTheme(newState is LightThemeState ? 'light' : 'dark');

    emit(newState);
  }
}
