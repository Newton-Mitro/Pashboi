import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeScreenState(selectedIndex: 0)) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
