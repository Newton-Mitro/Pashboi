import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/network/api_service.dart';
import 'package:pashboi/core/network/network_info.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_data_source.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pashboi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/pages/authenticated/home/bloc/auth_bloc.dart';
import 'package:pashboi/pages/public/login_page/bloc/login_screen_bloc.dart';
import 'package:pashboi/pages/public/register_page/bloc/registration_screen_bloc.dart';
import 'domain/index.dart';

void registerAuthModule() {
  // Register Data Sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  // Register Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authDataSource: sl<AuthDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      localStorage: sl<LocalStorage>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegistrationUseCase>(
    () => RegistrationUseCase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(authRepository: sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetAuthUserUseCase>(
    () => GetAuthUserUseCase(authRepository: sl<AuthRepository>()),
  );

  // Register Bloc
  sl.registerFactory<LoginScreenBloc>(
    () => LoginScreenBloc(loginUseCase: sl<LoginUseCase>()),
  );

  sl.registerFactory<RegistrationScreenBloc>(
    () =>
        RegistrationScreenBloc(registrationUseCase: sl<RegistrationUseCase>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      logoutUseCase: sl<LogoutUsecase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
