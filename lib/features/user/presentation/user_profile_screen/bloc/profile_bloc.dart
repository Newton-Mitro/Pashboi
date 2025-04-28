import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/resources/response_state.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/domain/usecases/follow_user_usecase.dart';
import 'package:pashboi/features/user/domain/usecases/un_follow_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FollowUserUseCase followUserUseCase;
  final UnFollowUserUseCase unFollowUserUseCase;

  ProfileBloc({
    required this.followUserUseCase,
    required this.unFollowUserUseCase,
  }) : super(ProfileInitial()) {
    on<LoadUserProfileEvent>(_onProfileLoadEvent);
    on<FollowUserEvent>(_onFollowUserEvent);
    on<UnfollowUserEvent>(_onUnfollowUserEvent);
  }

  void _onProfileLoadEvent(
    LoadUserProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoaded(event.user));
  }

  void _onFollowUserEvent(
    FollowUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentUser = (state as ProfileLoaded).user;

      emit(ProfileLoading());
      final followUserPrams = FollowUserParams(followingUserId: event.userId);
      final dataState = await followUserUseCase(params: followUserPrams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(
          ProfileLoaded(
            currentUser.copyWith(
              isFollowing: true,
              followers: dataState.data?.followingCount,
            ),
          ),
        );
      }
    }
  }

  void _onUnfollowUserEvent(
    UnfollowUserEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      final currentUser = (state as ProfileLoaded).user;

      emit(ProfileLoading());
      final unfollowUserPrams = UnFollowUserParams(
        followingUserId: event.userId,
      );
      final dataState = await unFollowUserUseCase(params: unfollowUserPrams);
      if (dataState is SuccessData && dataState.data != null) {
        emit(
          ProfileLoaded(
            currentUser.copyWith(
              isFollowing: false,
              followers: dataState.data?.followingCount,
            ),
          ),
        );
      }
    }
  }
}
