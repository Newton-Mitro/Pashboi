import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
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
      final result = await getAuthUserUseCase.call(null);

      result.fold(
        (failure) => emit(Unauthenticated()),
        (user) => emit(Authenticated(user)),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      await logoutUseCase.call(LogoutParams());
      emit(Unauthenticated());
    });
  }
}
