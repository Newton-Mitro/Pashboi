import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/development_credits/data/data_sources/development_credit_data_source.dart';
import 'package:pashboi/features/public/development_credits/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/development_credits/data/repositories/development_credits_repository_impl.dart';
import 'package:pashboi/features/public/development_credits/domain/repositories/development_credits_repository.dart';
import 'package:pashboi/features/public/development_credits/domain/usecases/development_credits_usecase.dart';
import 'package:pashboi/features/public/development_credits/presentation/bloc/development_credit_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerDevelopmentCreditModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<DevelopmentCreditRemoteDataSource>(
    () => DevelopmentCreditRemoteDataSourceImpl(
      productApiService: sl<ProductApiService>(),
    ),
  );

  sl.registerLazySingleton<DevelopmentCreditsLocalDataSource>(
    () => DevelopmentCreditsLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  sl.registerLazySingleton<DevelopmentCreditsRepository>(
    () => DevelopmentCreditsRepositoryImpl(
      developmentCreditRemoteDataSource:
          sl<DevelopmentCreditRemoteDataSource>(),
      developmentCreditsLocalDataSource:
          sl<DevelopmentCreditsLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerLazySingleton<DevelopmentCreditsUseCase>(
    () => DevelopmentCreditsUseCase(
      developmentCreditsRepository: sl<DevelopmentCreditsRepository>(),
    ),
  );

  sl.registerFactory<DevelopmentCreditBloc>(
    () => DevelopmentCreditBloc(
      developmentCreditsUseCase: sl<DevelopmentCreditsUseCase>(),
    ),
  );

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
