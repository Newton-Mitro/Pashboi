import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/login_usecase.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUseCase loginUseCase;

  LoginScreenBloc({required this.loginUseCase}) : super(LoginInitialState()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      final loginParams = LoginParams(
        email: event.username,
        password: event.password,
      );
      final dataState = await loginUseCase.call(params: loginParams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(LoginSuccessState(dataState.data!));
      }

      if (dataState is FailedData && dataState.error != null) {
        switch (dataState.error) {
          case NetworkFailure():
            emit(LoginErrorState(dataState.error!.message));
            break;
          case UnauthorizedFailure():
            emit(LoginErrorState(dataState.error!.message));
            break;
          case ServerFailure():
            emit(LoginErrorState(dataState.error!.message));
            break;
          case CacheFailure():
            emit(LoginErrorState(dataState.error!.message));
            break;
          default:
            emit(LoginErrorState(dataState.error!.message));
        }
      }

      if (dataState is ValidationFailedData &&
          dataState.errors!.errors.isNotEmpty) {
        emit(LoginValidationErrorState(dataState.errors!.errors));
      }
    });
  }
}
