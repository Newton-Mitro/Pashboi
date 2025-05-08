import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/features/onboarding/data/data_sources/onboarding_local_datasource.dart';
import 'package:pashboi/features/onboarding/data/repositories/onboarding_info_repository_impl.dart';
import 'package:pashboi/features/onboarding/domain/repositories/onboarding_info_repository.dart';
import 'package:pashboi/features/onboarding/domain/usecases/get_onboarding_infos_usecase.dart';
import 'package:pashboi/features/onboarding/domain/usecases/get_onboarding_seen_usecase.dart';
import 'package:pashboi/features/onboarding/domain/usecases/set_onboarding_seen_usecase.dart';
import 'package:pashboi/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';

void registerOnboardingModule() {
  // Register Data Sources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(localStorage: sl<LocalStorage>()),
  );

  // Register Repository
  sl.registerLazySingleton<OnboardingInfoRepository>(
    () => OnboardingInfoRepositoryImpl(
      localDataSource: sl<OnboardingLocalDataSource>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<GetOnboardingSeenUseCase>(
    () => GetOnboardingSeenUseCase(repository: sl<OnboardingInfoRepository>()),
  );
  sl.registerLazySingleton<SetOnboardingSeenUseCase>(
    () => SetOnboardingSeenUseCase(repository: sl<OnboardingInfoRepository>()),
  );
  sl.registerLazySingleton<GetOnboardingInfosUseCase>(
    () => GetOnboardingInfosUseCase(repository: sl<OnboardingInfoRepository>()),
  );

  // Register Bloc
  sl.registerFactory<OnboardingPageBloc>(
    () => OnboardingPageBloc(
      setOnBoardingSeenUseCase: sl<SetOnboardingSeenUseCase>(),
      getOnBoardingSeenUseCase: sl<GetOnboardingSeenUseCase>(),
      getOnBoardingInfosUseCase: sl<GetOnboardingInfosUseCase>(),
    ),
  );
}
