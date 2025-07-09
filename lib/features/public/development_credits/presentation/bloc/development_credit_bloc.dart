import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/domain/usecases/development_credits_usecase.dart';

part 'development_credit_event.dart';
part 'development_credit_state.dart';

class DevelopmentCreditBloc
    extends Bloc<DevelopmentCreditEvent, DevelopmentCreditState> {
  final DevelopmentCreditsUseCase developmentCreditsUseCase;

  DevelopmentCreditBloc({required this.developmentCreditsUseCase})
    : super(DevelopmentCreditInitial()) {
    on<DevelopmentCreditEvent>((event, emit) async {
      emit(DevelopmentCreditLoading());

      final dataState = await developmentCreditsUseCase.call(NoParams());
      dataState.fold(
        (failure) {
          emit(DevelopmentCreditError(error: failure.message));
        },
        (developmentCredit) {
          emit(DevelopmentCreditSuccess(developmentCredit: developmentCredit));
        },
      );
    });
  }
}
