part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String language;

  const LanguageState({required this.language});

  @override
  List<Object?> get props => [language];

  LanguageState copyWith({String? language}) {
    return LanguageState(language: language ?? this.language);
  }
}
