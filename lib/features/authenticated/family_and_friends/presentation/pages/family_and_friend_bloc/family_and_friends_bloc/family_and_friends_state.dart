part of 'family_and_friends_bloc.dart';

class FamilyAndFriendsState extends Equatable {
  final bool isLoading;
  final String? error;
  final List<FamilyAndFriendEntity> familyAndFriends;
  final Map<String, String>? errors;

  const FamilyAndFriendsState({
    this.isLoading = false,
    this.error,
    this.familyAndFriends = const [],
    this.errors,
  });

  FamilyAndFriendsState copyWith({
    bool? isLoading,
    String? error,
    List<FamilyAndFriendEntity>? familyAndFriends,
    final Map<String, String>? errors,
  }) {
    return FamilyAndFriendsState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      familyAndFriends: familyAndFriends ?? this.familyAndFriends,
      errors: errors,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, familyAndFriends, errors];
}
