import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_app_event.dart';
part 'my_app_state.dart';

class MyAppBloc extends Bloc<MyAppEvent, MyAppState> {
  MyAppBloc() : super(MyAppInitial()) {
    on<MyAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
