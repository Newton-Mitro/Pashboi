import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/service_centers/domain/entites/service_center_entity.dart';
import 'package:pashboi/features/public/service_centers/domain/usecase/fetch_service_center_usecase.dart';

part 'service_center_event.dart';
part 'service_center_state.dart';

class ServiceCenterBloc extends Bloc<ServiceCenterEvent, ServiceCenterState> {
  final FetchServiceCenterUseCase fetchServiceCenterUseCase;

  ServiceCenterBloc({required this.fetchServiceCenterUseCase})
    : super(ServiceCenterInitial()) {
    on<ServiceCenterEvent>((event, emit) async {
      emit(ServiceCenterLoading());

      final dataState = await fetchServiceCenterUseCase.call(NoParams());

      dataState.fold(
        (failure) {
          emit(ServiceCenterError(error: failure.message));
        },
        (serviceCenter) {
          emit(ServiceCenterSuccess(serviceCenter: serviceCenter));
        },
      );
    });
  }
}
