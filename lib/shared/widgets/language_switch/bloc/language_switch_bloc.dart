import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/locale/services/locale_service.dart';

part 'language_switch_event.dart';
part 'language_switch_state.dart';

class LanguageSwitchBloc
    extends Bloc<LanguageSwitchEvent, LanguageSwitchState> {
  final LocaleService localeService;

  LanguageSwitchBloc({required this.localeService})
    : super(LanguageSwitchState(language: 'en')) {
    on<LanguageSwitchEvent>(_changeLanguage);
    on<LoadLocaleEvent>(_loadLocale);
  }

  // Load the language from local storage
  Future<void> _loadLocale(
    LoadLocaleEvent event,
    Emitter<LanguageSwitchState> emit,
  ) async {
    final locale = await localeService.getLocale();
    emit(LanguageSwitchState(language: locale));
  }

  // Change the language and update the locale
  Future<void> _changeLanguage(
    LanguageSwitchEvent event,
    Emitter<LanguageSwitchState> emit,
  ) async {
    if (event is SwitchLanguage) {
      await localeService.setLocale(event.language);
      emit(state.copyWith(language: event.language));
    }
  }
}
