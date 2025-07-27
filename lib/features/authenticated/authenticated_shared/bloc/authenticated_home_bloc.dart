import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authenticated_home_event.dart';
part 'authenticated_home_state.dart';

class AuthenticatedHomeBloc
    extends Bloc<AuthenticatedHomeEvent, AuthenticatedHomeState> {
  AuthenticatedHomeBloc() : super(const AuthenticatedHomeInitial()) {
    on<ChangePageEvent>((event, emit) {
      emit(PageChangedState(event.selectedPage));
    });
  }
}
