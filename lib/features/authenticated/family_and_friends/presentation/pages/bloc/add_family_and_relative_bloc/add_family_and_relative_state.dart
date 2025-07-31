part of 'add_family_and_relative_bloc.dart';

sealed class AddFamilyAndRelativeState extends Equatable {
  const AddFamilyAndRelativeState();

  @override
  List<Object> get props => [];
}

final class AddFamilyAndRelativeInitial extends AddFamilyAndRelativeState {}

class AddFamilyAndRelativeLoading extends AddFamilyAndRelativeState {}

final class AddFamilyAndRelativeValidationErrorState
    extends AddFamilyAndRelativeState {
  final Map<String, dynamic> errors;
  const AddFamilyAndRelativeValidationErrorState(this.errors);

  @override
  List<Object> get props => [errors];
}

class AddFamilyAndRelativeSuccess extends AddFamilyAndRelativeState {}

class AddFamilyAndRelativeFailure extends AddFamilyAndRelativeState {
  final String error;

  const AddFamilyAndRelativeFailure(this.error);

  @override
  List<Object> get props => [error];
}
