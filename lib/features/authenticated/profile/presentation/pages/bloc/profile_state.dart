part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final PersonEntity personEntity;

  const ProfileSuccess(this.personEntity);

  @override
  List<Object> get props => [personEntity];
}

final class ProfileError extends ProfileState {
  final String error;
  const ProfileError(this.error);

  @override
  List<Object> get props => [error];
}
