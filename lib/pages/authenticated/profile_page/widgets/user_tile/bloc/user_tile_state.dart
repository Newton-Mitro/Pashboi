part of 'user_tile_bloc.dart';

sealed class UserTileState extends Equatable {
  const UserTileState();

  @override
  List<Object> get props => [];
}

final class UserTileInitial extends UserTileState {}

final class UserTileLoading extends UserTileState {}

final class UserTileLoaded extends UserTileState {
  final UserEntity user;
  const UserTileLoaded(this.user);
}
