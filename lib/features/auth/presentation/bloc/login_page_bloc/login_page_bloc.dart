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
      emit(LoginLoadingState());
      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );
      final result = await loginUseCase.call(params: loginParams);
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
}
