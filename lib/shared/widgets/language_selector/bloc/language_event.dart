part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object?> get props => [];
}

class LanguageSelected extends LanguageEvent {
  final String language;

  const LanguageSelected({required this.language});

  @override
  List<Object?> get props => [language];
}

class LoadLocaleEvent extends LanguageEvent {}
