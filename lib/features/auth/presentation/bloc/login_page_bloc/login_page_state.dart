part of 'login_page_bloc.dart';

class LoginPageState extends Equatable {
  const LoginPageState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginPageState {}

class LoginLoadingState extends LoginPageState {}

class LoginSuccessState extends LoginPageState {
  final UserEntity authUser;
  const LoginSuccessState(this.authUser);
}

class LoginErrorState extends LoginPageState {
  final String message;
  const LoginErrorState(this.message);
}

class LoginValidationErrorState extends LoginPageState {
  final Map<String, dynamic> errors;
  const LoginValidationErrorState(this.errors);
}
