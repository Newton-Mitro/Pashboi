import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/datasource/accepted_fallback_request_remote_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/datasource/fallback_request_remote_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/repositories/accepted_fallback_request_repository_impl.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/repositories/fallback_request_repository_impl.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/repositories/accepted_fallback_request_repository.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/repositories/fallback_request_repository.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/usecase/accepted_fallback_request_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/usecase/fallback_request_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/presentation/bloc/fallback_request_bloc.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/presentation/wigets/bloc/accepted_fallback_request_bloc.dart';

void registerFallbackRequestModule() {
  // Register Data Sources
  sl.registerLazySingleton<FallbackRequestRemoteDataSource>(
    () => FallbackRequestRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  sl.registerLazySingleton<AcceptedFallbackRequestRemoteDataSource>(
    () => AcceptedFallbackRequestRemoteDataSourceImpl(
      apiService: sl<ApiService>(),
    ),
  );

  // Register Repository
  sl.registerLazySingleton<FallbackRequestRepository>(
    () => FallbackRequestRepositoryImpl(
      fallbackRequestRemoteDataSource: sl<FallbackRequestRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<AcceptedFallbackRequestRepository>(
    () => AcceptedFallbackRequestRepositoryImpl(
      acceptedFallbackRequestRemoteDataSource:
          sl<AcceptedFallbackRequestRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FallbackRequestUseCaseUseCase>(
    () => FallbackRequestUseCaseUseCase(
      fallbackRequestRepository: sl<FallbackRequestRepository>(),
    ),
  );

  sl.registerLazySingleton<AcceptedFallbackUseCase>(
    () => AcceptedFallbackUseCase(
      repositoryInterface: sl<AcceptedFallbackRequestRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<FallbackRequestBloc>(
    () => FallbackRequestBloc(
      fallbackRequestUseCase: sl<FallbackRequestUseCaseUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );

  sl.registerFactory<AcceptedFallbackRequestBloc>(
    () => AcceptedFallbackRequestBloc(
      acceptedFallbackRequestUseCase: sl<AcceptedFallbackUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
