part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class IsAuthenticatedEvent extends AuthEvent {
  const IsAuthenticatedEvent();
}

final class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
