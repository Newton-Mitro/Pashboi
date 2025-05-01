// import 'package:pashboi/core/injection.dart';
// import 'package:pashboi/core/network/api_service.dart';
// import 'package:pashboi/core/network/network_info.dart';
// import 'package:pashboi/pages/authenticated/profile_page/bloc/profile_bloc.dart';
// import 'package:pashboi/pages/authenticated/profile_page/widgets/user_tile/bloc/user_tile_bloc.dart';

// void registerUserModule() {
//   // Data Sources
//   sl.registerLazySingleton<UsersDataSource>(
//     () => UserProfileRemoteDataSourceImpl(authApiService: sl<ApiService>()),
//   );

//   // Repository
//   sl.registerLazySingleton<UserRepository>(
//     () => UserRepositoryImpl(
//       remoteDataSource: sl<UsersDataSource>(),
//       networkInfo: sl<NetworkInfo>(),
//     ),
//   );

//   // Use Cases
//   sl.registerLazySingleton(
//     () => FetchProfileUseCase(userRepository: sl<UserRepository>()),
//   );

//   // Bloc
//   sl.registerFactory(
//     () => ProfileBloc(
//       followUserUseCase: sl<FollowUserUseCase>(),
//       unFollowUserUseCase: sl<UnFollowUserUseCase>(),
//     ),
//   );

//   sl.registerFactory(
//     () => UserTileBloc(
//       followUserUseCase: sl<FollowUserUseCase>(),
//       unFollowUserUseCase: sl<UnFollowUserUseCase>(),
//     ),
//   );
// }
