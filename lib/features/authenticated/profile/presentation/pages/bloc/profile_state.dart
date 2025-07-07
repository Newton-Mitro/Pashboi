part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final PersonEntity? personEntity;
  final String? error;

  const ProfileState({this.isLoading = false, this.personEntity, this.error});

  ProfileState copyWith({
    bool? isLoading,
    PersonEntity? personEntity,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      personEntity: personEntity ?? this.personEntity,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, personEntity, error];
}
