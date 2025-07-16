import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/data/repositories/deposit_policy_repository_impl.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_policy_repository.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/bloc/deposit_policy_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerDepositPolicyModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // Register Data Sources
  sl.registerLazySingleton<DepositPolicyRemoteDataSource>(
    () => DepositPolicyRemoteDataSourceImpl(
      productApiService: sl<ProductApiService>(),
    ),
  );

  sl.registerLazySingleton<DepositPolicyLocalDataSource>(
    () => DepositPolicyLocalDataSourceImpl(
      // productApiService: sl<ProductApiService>(),
      sl<SharedPreferences>(),
    ),
  );

  // Register Repository
  sl.registerLazySingleton<DepositPolicyRepository>(
    () => DepositPolicyRepositoryImpl(
      depositPolicyRemoteDataSource: sl<DepositPolicyRemoteDataSource>(),
      depositPolicyLocalDataSource: sl<DepositPolicyLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FetchDepositPolicyUseCase>(
    () => FetchDepositPolicyUseCase(
      depositPolicyRepository: sl<DepositPolicyRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<DepositPolicyBloc>(
    () => DepositPolicyBloc(
      fetchDepositPolicyUseCase: sl<FetchDepositPolicyUseCase>(),
    ),
  );

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
