import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/index.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LocalStorage localStorage;
  LanguageBloc({required this.localStorage})
    : super(LanguageState(language: 'bn')) {
    on<LanguageEvent>(_changeLanguage);
    on<LoadLocaleEvent>(_loadLocale);
  }

  Future<void> _loadLocale(
    LoadLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final locale = await localStorage.getString(Constants.localeKey) ?? 'bn';
    emit(LanguageState(language: locale));
  }

  // Method to handle language change event
  void _changeLanguage(LanguageEvent event, Emitter<LanguageState> emit) async {
    if (event is LanguageSelected) {
      await localStorage.saveString(Constants.localeKey, event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
