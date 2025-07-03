import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/public/service/domain/usecases/fetch_service_policy_usecase.dart';
import 'package:pashboi/features/public/service/presentation/bloc/service_policy_state.dart';

part 'service_policy_event.dart';

class ServicePolicyBloc extends Bloc<ServicePolicyEvent, ServicePolicyState> {
  final FetchServicePolicyUseCase fetchServicePolicyUseCase;
  ServicePolicyBloc({required this.fetchServicePolicyUseCase})
    : super(ServicePolicyInitial()) {
    on<ServicePolicyEvent>((event, emit) async {
      emit(ServiceProductLoading());
      final dataState = await fetchServicePolicyUseCase.call(
        FetchServicePolicyProps(
          categoryId: '1642dd57-cdf0-419a-8a56-c5e2358d5eda',
        ),
      );

      dataState.fold(
        (failure) {
          emit(ServicePolicyError(error: failure.message));
        },
        (depositPolicies) {
          emit(ServicePolicySuccess(servicePolicies: depositPolicies));
        },
      );
    });
  }
}
