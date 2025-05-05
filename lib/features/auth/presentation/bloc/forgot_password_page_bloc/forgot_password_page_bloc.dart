import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/features/auth/domain/usecases/forgot_password_usecase.dart';

part 'forgot_password_page_event.dart';
part 'forgot_password_page_state.dart';

class ForgotPasswordPageBloc
    extends Bloc<ForgotPasswordPageEvent, ForgotPasswordPageState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordPageBloc({required this.forgotPasswordUseCase})
    : super(ForgotPasswordInitial()) {
    on<SendForgotPasswordOtpEvent>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        await forgotPasswordUseCase(event.mobileNumber);
        emit(ForgotPasswordSuccess());
      } catch (e) {
        emit(ForgotPasswordFailure(e.toString()));
      }
    });
  }
}
