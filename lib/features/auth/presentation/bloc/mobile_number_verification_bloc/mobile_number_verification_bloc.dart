import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mobile_number_verification_event.dart';
part 'mobile_number_verification_state.dart';

class MobileNumberVerificationBloc extends Bloc<MobileNumberVerificationEvent, MobileNumberVerificationState> {
  MobileNumberVerificationBloc() : super(MobileNumberVerificationInitial()) {
    on<MobileNumberVerificationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
