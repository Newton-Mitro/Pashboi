part of 'login_screen_bloc.dart';

class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginScreenState {}

class LoginLoadingState extends LoginScreenState {}

class LoginSuccessState extends LoginScreenState {
  final AuthUserEntity authUser;
  const LoginSuccessState(this.authUser);
}

class LoginErrorState extends LoginScreenState {
  final String message;
  const LoginErrorState(this.message);
}

class LoginValidationErrorState extends LoginScreenState {
  final Map<String, dynamic> errors;
  const LoginValidationErrorState(this.errors);
}
