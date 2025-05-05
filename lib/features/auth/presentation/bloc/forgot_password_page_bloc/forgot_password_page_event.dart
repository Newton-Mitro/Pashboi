part of 'forgot_password_page_bloc.dart';

sealed class ForgotPasswordPageEvent {}

class SendForgotPasswordOtpEvent extends ForgotPasswordPageEvent {
  final String mobileNumber;
  SendForgotPasswordOtpEvent(this.mobileNumber);
}
