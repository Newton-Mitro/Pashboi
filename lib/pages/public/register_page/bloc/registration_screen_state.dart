part of 'registration_screen_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

final class RegistrationInitialState extends RegistrationState {}

final class RegistrationLoadingState extends RegistrationState {}

final class RegistrationSuccessState extends RegistrationState {
  final AuthUserEntity authUser;
  const RegistrationSuccessState(this.authUser);
}

final class RegistrationErrorState extends RegistrationState {
  final String message;
  const RegistrationErrorState(this.message);
}

final class RegistrationValidationErrorState extends RegistrationState {
  final Map<String, dynamic> errors;
  const RegistrationValidationErrorState(this.errors);
}
