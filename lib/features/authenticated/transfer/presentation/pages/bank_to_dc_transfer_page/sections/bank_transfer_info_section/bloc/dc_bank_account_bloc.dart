import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dc_bank_account_event.dart';
part 'dc_bank_account_state.dart';

class DcBankAccountBloc extends Bloc<DcBankAccountEvent, DcBankAccountState> {
  DcBankAccountBloc() : super(DcBankAccountInitial()) {
    on<DcBankAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
