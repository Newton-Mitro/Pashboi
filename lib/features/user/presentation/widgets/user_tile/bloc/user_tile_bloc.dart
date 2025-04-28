import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:pashboi/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'user_tile_event.dart';
part 'user_tile_state.dart';

class UserTileBloc extends Bloc<UserTileEvent, UserTileState> {
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;

  UserTileBloc({
    required this.followUserUseCase,
    required this.unFollowUserUseCase,
  }) : super(UserTileInitial()) {
    on<LoadUserEvent>(_onUserTileLoadEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnfollowUserEvent>(_onUnfollowUserEvent);
  }

  void _onUserTileLoadEvent(
    LoadUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    emit(UserTileLoading());
    emit(UserTileLoaded(event.user));
  }

  void _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    if (state is UserTileLoaded) {
      final currentUser = (state as UserTileLoaded).user;

      emit(UserTileLoading());
      final followUserPrams = FollowUserParams(followingUserId: event.userId);
      final dataState = await followUserUseCase(params: followUserPrams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(UserTileLoaded(currentUser.copyWith(isFollowing: true)));
      }

      if (dataState is FailedData) {
        emit(UserTileLoaded(currentUser.copyWith(isFollowing: false)));
      }
    }
  }

  void _onUnfollowUserEvent(
    UnfollowUserEvent event,
    Emitter<UserTileState> emit,
  ) async {
    if (state is UserTileLoaded) {
      final currentUser = (state as UserTileLoaded).user;

      emit(UserTileLoading());
      final unfollowUserPrams = UnFollowUserParams(
        followingUserId: event.userId,
      );
      final dataState = await unFollowUserUseCase(params: unfollowUserPrams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(UserTileLoaded(currentUser.copyWith(isFollowing: false)));
      }

      if (dataState is FailedData) {
        emit(UserTileLoaded(currentUser.copyWith(isFollowing: true)));
      }
    }
  }
}
