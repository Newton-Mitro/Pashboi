import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/service_centers/data/data_source/local_datasource.dart';
import 'package:pashboi/features/public/service_centers/data/data_source/remort_service_center_datasource.dart';
import 'package:pashboi/features/public/service_centers/data/repositories/service_center_repository_impl.dart';
import 'package:pashboi/features/public/service_centers/domain/repositories/service_center_repository.dart';
import 'package:pashboi/features/public/service_centers/domain/usecase/fetch_service_center_usecase.dart';
import 'package:pashboi/features/public/service_centers/presentation/bloc/service_center_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerServiceCenterModule() async {
  sl.registerLazySingleton<ServiceCenterRemoteDataSource>(
    () => ServiceCenterRemoteDataSourceImpl(
      productApiService: sl<ProductApiService>(),
    ),
  );
  sl.registerLazySingleton<ServiceCenterLocalDataSource>(
    () => ServiceCenterLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ServiceCenterRepository>(
    () => ServiceCenterRepositoryImpl(
      remoteDataSource: sl<ServiceCenterRemoteDataSource>(),
      localDataSource: sl<ServiceCenterLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<FetchServiceCenterUseCase>(
    () => FetchServiceCenterUseCase(
      serviceCenterRepository: sl<ServiceCenterRepository>(),
    ),
  );

  sl.registerFactory<ServiceCenterBloc>(
    () => ServiceCenterBloc(
      fetchServiceCenterUseCase: sl<FetchServiceCenterUseCase>(),
    ),
  );
}
