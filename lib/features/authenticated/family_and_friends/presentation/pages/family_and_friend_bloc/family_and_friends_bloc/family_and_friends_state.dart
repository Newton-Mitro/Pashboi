part of 'family_and_friends_bloc.dart';

class FamilyAndFriendsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<FamilyAndFriendEntity> familyAndFriends;

  const FamilyAndFriendsState({
    this.isLoading = false,
    this.error,
    this.familyAndFriends = const [],
  });

  FamilyAndFriendsState copyWith({
    bool? isLoading,
    String? error,
    List<FamilyAndFriendEntity>? familyAndFriends,
  }) {
    return FamilyAndFriendsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      familyAndFriends: familyAndFriends ?? this.familyAndFriends,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, familyAndFriends];
}

final class FamilyAndFriendValidationError extends FamilyAndFriendsState {
  final Map<String, String> errors;

  const FamilyAndFriendValidationError(this.errors);

  @override
  List<Object> get props => [errors];
}
