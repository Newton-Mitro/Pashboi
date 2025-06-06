part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;
  LoginRequested({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class LogoutRequested extends AuthEvent {}

class AuthUserCheck extends AuthEvent {}
