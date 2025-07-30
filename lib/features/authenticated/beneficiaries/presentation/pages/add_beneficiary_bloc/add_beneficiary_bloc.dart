import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_beneficiary_event.dart';
part 'add_beneficiary_state.dart';

class AddBeneficiaryBloc extends Bloc<AddBeneficiaryEvent, AddBeneficiaryState> {
  AddBeneficiaryBloc() : super(AddBeneficiaryInitial()) {
    on<AddBeneficiaryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
