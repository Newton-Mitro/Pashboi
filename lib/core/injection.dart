import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:pashboi/core/services/logging/logger_service.dart';
import 'package:pashboi/core/services/logging/logger_service_impl.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/network_info_impl.dart';
import 'package:pashboi/core/services/app_status/app_status_service.dart';
import 'package:pashboi/core/services/app_status/app_status_service_impl.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/core/services/local_storage/local_storage_impl.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/core/locale/services/locale_service.dart';
import 'package:pashboi/core/locale/services/locale_service_impl.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';
import 'package:pashboi/core/theme/services/theme_service_impl.dart';
import 'services/network/api_service.dart';

final sl = GetIt.instance;

Future<void> registerCoreServices() async {
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      localStorage: sl<LocalStorage>(),
      loggerService: sl<LoggerService>(),
    ),
  );

  // ✅ Logging Service
  sl.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());
  sl.registerLazySingleton<LocaleService>(
    () => LocaleServiceImpl(sl<LocalStorage>()),
  );
  sl.registerLazySingleton<ThemeService>(
    () => ThemeServiceImpl(sl<LocalStorage>()),
  );

  // ✅ Network Info (Detects Internet Connectivity)
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl<Connectivity>()),
  );

  // Register Bloc
  sl.registerFactory<LanguageBloc>(
    () => LanguageBloc(localeService: sl<LocaleService>()),
  );

  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(themeService: sl<ThemeService>()),
  );

  sl.registerLazySingleton<AppStatusService>(() => AppStatusServiceImpl());
}
