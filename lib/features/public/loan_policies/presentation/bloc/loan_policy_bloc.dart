import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/usecases/fetch_loant_policy_usecase.dart';

part 'loan_policy_event.dart';
part 'loan_policy_state.dart';

class LoanPolicyBloc extends Bloc<LoanPolicyEvent, LoanPolicyState> {
  final FetchLoanPolicyUseCase fetchLoanPolicyUseCase;

  LoanPolicyBloc({required this.fetchLoanPolicyUseCase})
    : super(LoanPolicyInitial()) {
    on<LoanPolicyEvent>((event, emit) async {
      emit(LoanPolicyLoading());

      final dataState = await fetchLoanPolicyUseCase.call(
        FetchLoanPolicyProps(
          categoryId: '95876bf4-5cc9-4ab7-9884-01b4ca58bf2b',
        ),
      );
      dataState.fold(
        (failure) {
          emit(LoanPolicyerror(error: failure.message));
        },
        (depositPolicies) {
          emit(LoanPolicySuccess(loanPolicies: depositPolicies));
        },
      );
    });
  }
}
