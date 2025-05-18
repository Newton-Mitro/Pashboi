import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/logout_usecase.dart';

part 'authenticated_home_event.dart';
part 'authenticated_home_state.dart';

class AuthenticatedHomeBloc
    extends Bloc<AuthenticatedHomeEvent, AuthenticatedHomeState> {
  final LogoutUsecase logoutUseCase;
  final GetAuthUserUseCase getAuthUserUseCase;

  AuthenticatedHomeBloc({
    required this.logoutUseCase,
    required this.getAuthUserUseCase,
  }) : super(const AuthenticatedHomeInitial()) {
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

    on<ChangePageEvent>((event, emit) {
      final currentState = state;

      if (currentState is Authenticated) {
        // Change selected page but keep the authenticated user
        emit(PageChangedState(event.selectedPage));
      } else if (currentState is AuthenticatedHomeInitial) {
        // Just update page on initial state
        emit(PageChangedState(event.selectedPage));
      } else if (currentState is PageChangedState) {
        // Update page in PageChangedState
        emit(PageChangedState(event.selectedPage));
      }
    });
  }
}
