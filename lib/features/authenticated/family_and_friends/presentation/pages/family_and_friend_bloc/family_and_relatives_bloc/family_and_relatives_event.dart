part of 'family_and_relatives_bloc.dart';

sealed class FamilyAndRelativesEvent extends Equatable {
  const FamilyAndRelativesEvent();

  @override
  List<Object> get props => [];
}

class FetchFamilyAndRelatives extends FamilyAndRelativesEvent {}

class AddFamilyAndRelative extends FamilyAndRelativesEvent {
  final int childPersonId;
  final String relationTypeCode;
  final String searchAccountNumber;

  const AddFamilyAndRelative({
    required this.childPersonId,
    required this.relationTypeCode,
    required this.searchAccountNumber,
  });
}
