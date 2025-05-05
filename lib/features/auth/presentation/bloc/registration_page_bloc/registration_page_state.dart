part of 'registration_page_bloc.dart';

sealed class RegistrationPageState extends Equatable {
  const RegistrationPageState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitialState extends RegistrationPageState {}

final class RegistrationLoadingState extends RegistrationPageState {}

final class RegistrationSuccessState extends RegistrationPageState {
  final UserEntity authUser;
  const RegistrationSuccessState(this.authUser);
}

final class RegistrationErrorState extends RegistrationPageState {
  final String message;
  const RegistrationErrorState(this.message);
}

final class RegistrationValidationErrorState extends RegistrationPageState {
  final Map<String, dynamic> errors;
  const RegistrationValidationErrorState(this.errors);
}
