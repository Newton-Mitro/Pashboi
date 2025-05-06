import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/shared/widgets/language_selector/services/locale_service.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LocaleService localeService;

  LanguageBloc({required this.localeService})
    : super(LanguageState(language: 'bn')) {
    on<LanguageEvent>(_changeLanguage);
    on<LoadLocaleEvent>(_loadLocale);
  }

  // Load the language from local storage
  Future<void> _loadLocale(
    LoadLocaleEvent event,
    Emitter<LanguageState> emit,
  ) async {
    final locale = await localeService.getLocale();
    emit(LanguageState(language: locale));
  }

  // Change the language and update the locale
  Future<void> _changeLanguage(
    LanguageEvent event,
    Emitter<LanguageState> emit,
  ) async {
    if (event is LanguageSelected) {
      await localeService.setLocale(event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
