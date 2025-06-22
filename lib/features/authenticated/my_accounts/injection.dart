import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';

void registerMyAccountsModule() async {
  // Register Data Sources
  // sl.registerLazySingleton<AuthRemoteDataSource>(
  //   () => AuthRemoteDataSourceImpl(apiService: sl<ApiService>()),
  // );

  // Register Repository
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(
  //     authRemoteDataSource: sl<AuthRemoteDataSource>(),
  //     authLocalDataSource: sl<AuthLocalDataSource>(),
  //     networkInfo: sl<NetworkInfo>(),
  //   ),
  // );

  // Register Use Cases
  // sl.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(authRepository: sl<AuthRepository>()),
  // );

  // Register Bloc

  sl.registerFactory<AccountOpeningStepsBloc>(() => AccountOpeningStepsBloc());
}
