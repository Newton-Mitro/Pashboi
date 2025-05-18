part of 'authenticated_home_bloc.dart';

sealed class AuthenticatedHomeEvent extends Equatable {
  const AuthenticatedHomeEvent();

  @override
  List<Object> get props => [];
}

final class IsAuthenticatedEvent extends AuthenticatedHomeEvent {
  const IsAuthenticatedEvent();
}

final class LogoutEvent extends AuthenticatedHomeEvent {
  const LogoutEvent();
}

final class ChangePageEvent extends AuthenticatedHomeEvent {
  final int selectedPage;

  const ChangePageEvent(this.selectedPage);

  @override
  List<Object> get props => [selectedPage];
}
