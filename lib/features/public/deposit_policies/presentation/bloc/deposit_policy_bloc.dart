import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';

part 'deposit_policy_event.dart';
part 'deposit_policy_state.dart';

class DepositPolicyBloc extends Bloc<DepositPolicyEvent, DepositPolicyState> {
  final FetchDepositPolicyUseCase fetchDepositPolicyUseCase;
  DepositPolicyBloc({required this.fetchDepositPolicyUseCase})
    : super(DepositPolicyInitial()) {
    on<DepositPolicyEvent>((event, emit) async {
      emit(DepositProductLoading());

      final dataState = await fetchDepositPolicyUseCase.call(
        FetchPageProps(categoryId: 'c73d747a-4b09-4bf9-a869-61f47259cd7f'),
      );

      dataState.fold(
        (failure) {
          emit(DepositPolicyError(error: failure.message));
        },
        (depositPolicies) {
          emit(DepositPolicySuccess(depositPolicies: depositPolicies));
        },
      );
    });
  }
}
