import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/repositories/family_and_friend_repository.impl.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/family_and_friend_repository.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/bloc/get_family_and_friends_bloc/family_and_friends_bloc.dart';

void registerFamilyAndFriendsModule() async {
  // Register Data Sources
  sl.registerLazySingleton<FamilyAndFriendRemoteDataSource>(
    () => FamilyAndFriendRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<FamilyAndFriendRepository>(
    () => FamilyAndFriendRepositoryImpl(
      familyAndFriendRemoteDataSource: sl<FamilyAndFriendRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<GetFamilyAndFriendsUseCase>(
    () => GetFamilyAndFriendsUseCase(
      familyAndFriendRepository: sl<FamilyAndFriendRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<FamilyAndFriendsBloc>(
    () => FamilyAndFriendsBloc(
      getFamilyAndFriendsUseCase: sl<GetFamilyAndFriendsUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
