part of 'language_switch_bloc.dart';

class LanguageSwitchState extends Equatable {
  final String language;

  const LanguageSwitchState({required this.language});

  @override
  List<Object?> get props => [language];

  LanguageSwitchState copyWith({String? language}) {
    return LanguageSwitchState(language: language ?? this.language);
  }
}
