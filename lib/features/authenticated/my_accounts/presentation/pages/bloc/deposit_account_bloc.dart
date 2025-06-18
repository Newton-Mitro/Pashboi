import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';

part 'deposit_account_event.dart';
part 'deposit_account_state.dart';

class DepositAccountBloc
    extends Bloc<DepositAccountEvent, DepositAccountState> {
  DepositAccountBloc() : super(DepositAccountInitial()) {
    on<DepositAccountEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
