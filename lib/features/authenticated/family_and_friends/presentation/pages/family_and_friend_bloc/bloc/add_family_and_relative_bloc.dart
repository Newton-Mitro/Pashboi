import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_family_and_relative_event.dart';
part 'add_family_and_relative_state.dart';

class AddFamilyAndRelativeBloc extends Bloc<AddFamilyAndRelativeEvent, AddFamilyAndRelativeState> {
  AddFamilyAndRelativeBloc() : super(AddFamilyAndRelativeInitial()) {
    on<AddFamilyAndRelativeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
