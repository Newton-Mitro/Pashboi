part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserProfileEvent extends ProfileEvent {
  final UserEntity user;
  const LoadUserProfileEvent(this.user);
}

class FollowUserEvent extends ProfileEvent {
  final int userId;
  const FollowUserEvent(this.userId);
}

class UnfollowUserEvent extends ProfileEvent {
  final int userId;
  const UnfollowUserEvent(this.userId);
}
