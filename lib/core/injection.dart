import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:pashboi/core/logging/logger_service.dart';
import 'package:pashboi/core/logging/logger_service_impl.dart';
import 'package:pashboi/core/network/network_info.dart';
import 'package:pashboi/core/network/network_info_impl.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/core/utils/local_storage_impl.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'network/api_service.dart';

final sl = GetIt.instance;

Future<void> registerCoreServices() async {
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());
  sl.registerLazySingleton<ApiService>(
    () => ApiService(
      localStorage: sl<LocalStorage>(),
      loggerService: sl<LoggerService>(),
    ),
  );

  // ✅ Logging Service
  sl.registerLazySingleton<LoggerService>(() => LoggerServiceImpl());

  // ✅ Network Info (Detects Internet Connectivity)
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl<Connectivity>()),
  );

  // Register Bloc
  sl.registerFactory<LanguageBloc>(
    () => LanguageBloc(localStorage: sl<LocalStorage>()),
  );

  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(localStorage: sl<LocalStorage>()),
  );
}
