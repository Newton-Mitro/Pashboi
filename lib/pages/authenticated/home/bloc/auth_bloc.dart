import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogoutUsecase logoutUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  AuthBloc({required this.logoutUseCase, required this.getAuthUserUseCase})
    : super(AuthInitial()) {
    on<IsAuthenticatedEvent>((event, emit) async {
      emit(AuthLoading());
      final authUserState = await getAuthUserUseCase.call();

      if (authUserState is SuccessData) {
        emit(Authenticated(authUserState.data!));
      }

      if (authUserState is FailedData) {
        emit(Unauthenticated());
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      await logoutUseCase.call();
      emit(Unauthenticated());
    });
  }
}
