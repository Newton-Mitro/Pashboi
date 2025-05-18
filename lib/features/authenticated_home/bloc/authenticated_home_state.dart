part of 'authenticated_home_bloc.dart';

sealed class AuthenticatedHomeState extends Equatable {
  const AuthenticatedHomeState();

  @override
  List<Object> get props => [];
}

class AuthenticatedHomeInitial extends AuthenticatedHomeState {
  final int selectedPage;
  const AuthenticatedHomeInitial({this.selectedPage = 0});

  @override
  List<Object> get props => [selectedPage];
}

final class AuthLoading extends AuthenticatedHomeState {}

final class Authenticated extends AuthenticatedHomeState {
  final UserEntity authUser;
  final int selectedPage;

  const Authenticated(this.authUser, {this.selectedPage = 0});

  Authenticated copyWith({UserEntity? authUser, int? selectedPage}) {
    return Authenticated(
      authUser ?? this.authUser,
      selectedPage: selectedPage ?? this.selectedPage,
    );
  }

  @override
  List<Object> get props => [authUser, selectedPage];
}

final class Unauthenticated extends AuthenticatedHomeState {}

final class AuthError extends AuthenticatedHomeState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class PageChangedState extends AuthenticatedHomeState {
  final int selectedPage;
  const PageChangedState(this.selectedPage);

  PageChangedState copyWith({int? selectedPage}) {
    return PageChangedState(selectedPage ?? this.selectedPage);
  }

  @override
  List<Object> get props => [selectedPage];
}
