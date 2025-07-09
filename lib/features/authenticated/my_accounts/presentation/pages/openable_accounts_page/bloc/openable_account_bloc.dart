import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';

part 'openable_account_event.dart';
part 'openable_account_state.dart';

class OpenableAccountBloc
    extends Bloc<OpenableAccountEvent, OpenableAccountState> {
  OpenableAccountBloc() : super(OpenableAccountInitial()) {
    on<OpenableAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
