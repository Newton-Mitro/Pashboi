part of 'registration_screen_bloc.dart';

sealed class RegistrationScreenEvent extends Equatable {
  const RegistrationScreenEvent();

  @override
  List<Object> get props => [];
}

final class RegisterEvent extends RegistrationScreenEvent {
  final String name;
  final String password;
  final String email;
  final String confirmPassword;

  const RegisterEvent({
    required this.name,
    required this.password,
    required this.email,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [name, password, email, confirmPassword];
}
