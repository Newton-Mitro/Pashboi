import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/authenticated_pages/cards/domain/entities/debit_card_entity.dart';

part 'debit_card_event.dart';
part 'debit_card_state.dart';

class DebitCardBloc extends Bloc<DebitCardEvent, DebitCardState> {
  DebitCardBloc() : super(DebitCardInitial()) {
    on<DebitCardEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
