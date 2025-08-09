import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/my_app/data/data_source/app_status_remote_datasource.dart';
import 'package:pashboi/features/my_app/data/data_source/app_status_mock_datasource.dart';
import 'package:pashboi/features/my_app/data/repositories/app_status_repository_impl.dart';
import 'package:pashboi/features/my_app/domain/repositories/app_status_repository.dart';
import 'package:pashboi/features/my_app/domain/usecases/fetch_app_status_usecase.dart';
import 'package:pashboi/features/my_app/presentation/bloc/my_app_bloc.dart';

void registerAppStatusModule() async {
  // Register Data Sources
  // sl.registerLazySingleton<AppStatusRemoteDataSource>(
  //   () => AppStatusRemoteDataSourceImpl(apiService: sl<ApiService>()),
  // );
  sl.registerLazySingleton<AppStatusRemoteDataSource>(
    () => AppStatusMockDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<AppStatusRepository>(
    () => AppStatusRepositoryImpl(
      remoteDataSource: sl<AppStatusRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FetchAppStatusUseCase>(
    () => FetchAppStatusUseCase(sl<AppStatusRepository>()),
  );

  // Register Bloc
  sl.registerFactory<AppStatusBloc>(
    () => AppStatusBloc(sl<FetchAppStatusUseCase>()),
  );
}
