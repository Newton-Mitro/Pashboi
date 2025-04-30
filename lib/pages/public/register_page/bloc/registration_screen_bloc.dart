import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/registration_usecase.dart';

part 'registration_screen_event.dart';
part 'registration_screen_state.dart';

class RegistrationScreenBloc
    extends Bloc<RegistrationScreenEvent, RegistrationState> {
  final RegistrationUseCase registrationUseCase;

  RegistrationScreenBloc({required this.registrationUseCase})
    : super(RegistrationInitialState()) {
    on<RegisterEvent>((event, emit) async {
      emit(RegistrationLoadingState());
      final registrationParams = RegistrationParams(
        name: event.name,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      final dataState = await registrationUseCase.call(
        params: registrationParams,
      );

      if (dataState is SuccessData && dataState.data != null) {
        emit(RegistrationSuccessState(dataState.data!));
      }

      if (dataState is FailedData && dataState.error != null) {
        switch (dataState.error) {
          case NetworkFailure():
            emit(RegistrationErrorState(dataState.error!.message));
            break;
          case UnauthorizedFailure():
            emit(RegistrationErrorState(dataState.error!.message));
            break;
          case ServerFailure():
            emit(RegistrationErrorState(dataState.error!.message));
            break;
          case CacheFailure():
            emit(RegistrationErrorState(dataState.error!.message));
            break;
          default:
            emit(RegistrationErrorState(dataState.error!.message));
        }
      }

      if (dataState is ValidationFailedData &&
          dataState.errors!.errors.isNotEmpty) {
        emit(RegistrationValidationErrorState(dataState.errors!.errors));
      }
    });
  }
}
