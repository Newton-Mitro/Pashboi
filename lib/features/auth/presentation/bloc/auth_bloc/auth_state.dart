part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final AuthUserEntity authUser;

  Authenticated(this.authUser);

  @override
  List<Object?> get props => [authUser];
}

class UnAuthenticated extends AuthState {}

final class AuthValidationErrorState extends AuthState {
  final Map<String, dynamic> errors;
  AuthValidationErrorState(this.errors);

  @override
  List<Object?> get props => [errors];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
