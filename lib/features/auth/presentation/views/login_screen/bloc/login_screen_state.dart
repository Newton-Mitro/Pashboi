part of 'login_screen_bloc.dart';

sealed class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginScreenState {}

final class LoginLoadingState extends LoginScreenState {}

final class LoginSuccessState extends LoginScreenState {
  final AuthUserEntity authUser;
  const LoginSuccessState(this.authUser);
}

final class LoginErrorState extends LoginScreenState {
  final String message;
  const LoginErrorState(this.message);
}

final class LoginValidationErrorState extends LoginScreenState {
  final Map<String, dynamic> errors;
  const LoginValidationErrorState(this.errors);
}
