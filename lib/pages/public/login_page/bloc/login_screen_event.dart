part of 'login_screen_bloc.dart';

sealed class LoginScreenEvent extends Equatable {
  const LoginScreenEvent();

  @override
  List<Object> get props => [];
}

final class LoginEvent extends LoginScreenEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}
