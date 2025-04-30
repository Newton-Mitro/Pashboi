part of 'user_tile_bloc.dart';

sealed class UserTileEvent extends Equatable {
  const UserTileEvent();

  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserTileEvent {
  final UserEntity user;
  const LoadUserEvent(this.user);
}

class FollowUserEvent extends UserTileEvent {
  final int userId;
  const FollowUserEvent(this.userId);
}

class UnfollowUserEvent extends UserTileEvent {
  final int userId;
  const UnfollowUserEvent(this.userId);
}
