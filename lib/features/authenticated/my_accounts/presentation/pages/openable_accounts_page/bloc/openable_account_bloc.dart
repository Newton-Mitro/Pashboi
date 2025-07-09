import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'openable_account_event.dart';
part 'openable_account_state.dart';

class OpenableAccountBloc extends Bloc<OpenableAccountEvent, OpenableAccountState> {
  OpenableAccountBloc() : super(OpenableAccountInitial()) {
    on<OpenableAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
