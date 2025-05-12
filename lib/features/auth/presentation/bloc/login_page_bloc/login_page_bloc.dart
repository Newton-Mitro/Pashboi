import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/login_usecase.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final LoginUseCase loginUseCase;

  LoginPageBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      // Local input validation
      final errors = <String, String>{};

      if (event.username.trim().isEmpty) {
        errors['email'] = 'Username is required';
      } else if (!_isValidEmail(event.username)) {
        errors['email'] = 'Enter a valid email address';
      }

      if (event.password.trim().isEmpty) {
        errors['password'] = 'Password is required';
      }

      if (errors.isNotEmpty) {
        emit(LoginValidationErrorState(errors));
        return;
      }

      emit(LoginLoadingState());

      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );

      final result = await loginUseCase.call(loginParams);

      result.fold(
        (failure) {
          if (failure is ValidationFailure) {
            emit(LoginValidationErrorState(failure.errors));
          } else {
            emit(LoginErrorState(failure.message));
          }
        },
        (user) {
          emit(LoginSuccessState(user));
        },
      );
    });
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(email);
  }
}
