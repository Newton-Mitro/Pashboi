import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/service/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/service/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/service/data/repositories/service_policy_repository_impl.dart';
import 'package:pashboi/features/public/service/domain/repositories/service_policy_repository.dart';
import 'package:pashboi/features/public/service/domain/usecases/fetch_service_policy_usecase.dart';
import 'package:pashboi/features/public/service/presentation/bloc/service_policy_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerServicePolicyModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // Register Data Sources
  sl.registerLazySingleton<ServicePolicyRemoteDataSource>(
    () => ServicePolicyRemoteDataSourceImpl(
      productApiService: sl<ProductApiService>(),
    ),
  );

  sl.registerLazySingleton<ServicePolicyLocalDataSource>(
    () => ServicePolicyLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ServicePolicyRepository>(
    () => ServicePolicyRepositoryImpl(
      servicePolicyRemoteDataSource: sl<ServicePolicyRemoteDataSource>(),
      servicePolicyLocalDataSource: sl<ServicePolicyLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FetchServicePolicyUseCase>(
    () => FetchServicePolicyUseCase(
      servicePolicyRepository: sl<ServicePolicyRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<ServicePolicyBloc>(
    () => ServicePolicyBloc(
      fetchServicePolicyUseCase: sl<FetchServicePolicyUseCase>(),
    ),
  );

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
