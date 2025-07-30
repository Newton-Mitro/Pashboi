part of 'add_beneficiary_bloc.dart';

sealed class AddBeneficiaryState extends Equatable {
  const AddBeneficiaryState();
  
  @override
  List<Object> get props => [];
}

final class AddBeneficiaryInitial extends AddBeneficiaryState {}
