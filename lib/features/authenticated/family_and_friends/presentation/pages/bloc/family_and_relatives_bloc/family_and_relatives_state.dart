part of 'family_and_relatives_bloc.dart';

abstract class FamilyAndRelativesState extends Equatable {
  const FamilyAndRelativesState();

  @override
  List<Object?> get props => [];
}

class FamilyAndRelativesInitial extends FamilyAndRelativesState {}

class FamilyAndRelativesLoading extends FamilyAndRelativesState {}

class FamilyAndRelativesLoaded extends FamilyAndRelativesState {
  final List<FamilyAndFriendEntity> familyAndFriends;

  const FamilyAndRelativesLoaded({required this.familyAndFriends});

  @override
  List<Object?> get props => [familyAndFriends];
}

class FamilyAndRelativeAddSuccess extends FamilyAndRelativesState {}

class FamilyAndRelativesFailure extends FamilyAndRelativesState {
  final String error;

  const FamilyAndRelativesFailure(this.error);

  @override
  List<Object?> get props => [error];
}
