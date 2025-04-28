part of 'language_bloc.dart';

sealed class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

final class LoadLocaleEvent extends LanguageEvent {
  final String language;
  const LoadLocaleEvent({this.language = 'en'});
}

final class LanguageSelected extends LanguageEvent {
  final String language;

  const LanguageSelected({this.language = 'en'});
}
