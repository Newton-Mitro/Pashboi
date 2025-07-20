import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/project/data/data_source/local_datasource.dart';
import 'package:pashboi/features/public/project/data/data_source/project_remote_data_source.dart';
import 'package:pashboi/features/public/project/data/repositories/project_repository_impl.dart';
import 'package:pashboi/features/public/project/domain/repositories/project_repository.dart';
import 'package:pashboi/features/public/project/domain/usecase/fetch_project_usecase.dart';
import 'package:pashboi/features/public/project/presentation/bloc/project_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerProjectModule() async {
  sl.registerLazySingleton<ProjectRemoteDataSource>(
    () =>
        ProjectRemoteDataSourceImpl(productApiService: sl<ProductApiService>()),
  );

  sl.registerLazySingleton<ProjectLocalDataSource>(
    () => ProjectLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(
      remoteDataSource: sl<ProjectRemoteDataSource>(),
      localDataSource: sl<ProjectLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<FetchProjectUseCase>(
    () => FetchProjectUseCase(projectRepository: sl<ProjectRepository>()),
  );

  sl.registerFactory<ProjectBloc>(
    () => ProjectBloc(projectUseCase: sl<FetchProjectUseCase>()),
  );
}
