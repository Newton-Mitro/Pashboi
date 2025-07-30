part of 'family_and_relatives_bloc.dart';

class FamilyAndRelativesState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<FamilyAndFriendEntity> familyAndFriends;
  final Map<String, String>? errors;

  const FamilyAndRelativesState({
    this.isLoading = false,
    this.error,
    this.familyAndFriends = const [],
    this.errors,
  });

  FamilyAndRelativesState copyWith({
    bool? isLoading,
    String? error,
    List<FamilyAndFriendEntity>? familyAndFriends,
    final Map<String, String>? errors,
  }) {
    return FamilyAndRelativesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      familyAndFriends: familyAndFriends ?? this.familyAndFriends,
      errors: errors,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, familyAndFriends, errors];
}
