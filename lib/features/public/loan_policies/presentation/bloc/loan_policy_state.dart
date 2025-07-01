part of 'loan_policy_bloc.dart';

sealed class LoanPolicyState extends Equatable {
  const LoanPolicyState();

  @override
  List<Object> get props => [];
}

final class LoanPolicyInitial extends LoanPolicyState {}

final class LoanPolicyLoading extends LoanPolicyState {}

final class LoanPolicySuccess extends LoanPolicyState {
  final List<LoanPolicyEntity> loanPolicies;
  const LoanPolicySuccess({required this.loanPolicies});

  @override
  List<Object> get props => [loanPolicies];
}

final class LoanPolicyerror extends LoanPolicyState {
  final String error;

  const LoanPolicyerror({required this.error});
  @override
  List<Object> get props => [error];
}
