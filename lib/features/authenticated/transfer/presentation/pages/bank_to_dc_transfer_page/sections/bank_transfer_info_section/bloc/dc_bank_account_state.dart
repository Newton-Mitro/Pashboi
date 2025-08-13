part of 'dc_bank_account_bloc.dart';

sealed class DcBankAccountState extends Equatable {
  const DcBankAccountState();
  
  @override
  List<Object> get props => [];
}

final class DcBankAccountInitial extends DcBankAccountState {}
