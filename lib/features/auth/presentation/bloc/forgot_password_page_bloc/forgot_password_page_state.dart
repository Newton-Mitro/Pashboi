part of 'forgot_password_page_bloc.dart';

sealed class ForgotPasswordPageState {}

class ForgotPasswordInitial extends ForgotPasswordPageState {}

class ForgotPasswordLoading extends ForgotPasswordPageState {}

class ForgotPasswordSuccess extends ForgotPasswordPageState {}

class ForgotPasswordFailure extends ForgotPasswordPageState {
  final String message;
  ForgotPasswordFailure(this.message);
}
