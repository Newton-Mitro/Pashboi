import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/home/presentation/home_screen/bloc/auth_bloc.dart';
import 'package:pashboi/features/home/presentation/notifier/notifiers.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/presentation/widgets/user_tile/bloc/user_tile_bloc.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserTileBloc>()..add(LoadUserEvent(user)),
        ),
        BlocProvider(
          create: (context) => sl<AuthBloc>()..add(IsAuthenticatedEvent()),
        ),
      ],
      child: BlocBuilder<UserTileBloc, UserTileState>(
        builder: (context, state) {
          if (state is UserTileLoaded) {
            return Card(
              color: Theme.of(context).colorScheme.surface,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  return ListTile(
                    minTileHeight: 60,
                    leading: CachedNetworkImage(
                      imageUrl: user.profilePicture ?? '',
                      imageBuilder:
                          (context, imageProvider) => ClipOval(
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                      placeholder:
                          (context, url) => SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget:
                          (context, url, error) => ClipOval(
                            child: Image.asset(
                              'assets/images/misc/avatar.png',
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    trailing:
                        authUserNotifier.value != null &&
                                (authUserNotifier.value?.id != state.user.id)
                            ? ElevatedButton(
                              onPressed: () {
                                state.user.isFollowing
                                    ? context.read<UserTileBloc>().add(
                                      UnfollowUserEvent(state.user.id),
                                    )
                                    : context.read<UserTileBloc>().add(
                                      FollowUserEvent(state.user.id),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    state.user.isFollowing
                                        ? const Color.fromARGB(255, 13, 82, 14)
                                        : const Color.fromARGB(255, 6, 47, 82),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                minimumSize: const Size(70, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                state.user.isFollowing ? 'Unfollow' : 'Follow',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
                    onTap: () {
                      if (authState is Authenticated &&
                          authState.authUser.user.id == state.user.id) {
                      } else {
                        Navigator.pushNamed(
                          context,
                          RoutesName.userProfilePage,
                          arguments: state.user,
                        );
                      }
                    },
                  );
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
