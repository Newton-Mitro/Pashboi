import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// Add this import
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/utils/local_storage.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LocalStorage localStorage;

  LanguageBloc({required this.localStorage})
    : super(LanguageState(language: 'bn')) {
    on<LanguageEvent>(_changeLanguage);
    on<LoadLocaleEvent>(_loadLocale);
  }

  // Load the language from local storage
  Future<void> _loadLocale(
    LoadLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final locale = await localStorage.getString(Constants.keyLocale) ?? 'en';
    emit(LanguageState(language: locale));
  }

  // Change the language and update the locale
  Future<void> _changeLanguage(
    LanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    if (event is LanguageSelected) {
      await localStorage.saveString(Constants.keyLocale, event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
