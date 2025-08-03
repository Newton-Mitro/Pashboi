import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/deposit/data/repositories/deposit_repository.impl.dart';
import 'package:pashboi/features/authenticated/deposit/domain/repositories/deposit_repository.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_from_bkash_page/bloc/deposit_from_bkash_steps_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_later_page/bloc/deposit_later_steps_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/bloc/deposit_now_steps_bloc.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/widgets/otp_verification_section/bloc/otp_bloc.dart';

void registerDepositModule() async {
  // Register Data Sources
  sl.registerLazySingleton<DepositRemoteDataSource>(
    () => DepositRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<DepositRepository>(
    () => DepositRepositoryImpl(
      depositRemoteDataSource: sl<DepositRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<SubmitDepositNowUseCase>(
    () => SubmitDepositNowUseCase(depositRepository: sl<DepositRepository>()),
  );

  // Register Bloc
  sl.registerFactory<DepositNowStepsBloc>(
    () => DepositNowStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
  sl.registerFactory<DepositLaterStepsBloc>(
    () => DepositLaterStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
  sl.registerFactory<DepositFromBkashStepsBloc>(
    () => DepositFromBkashStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
  sl.registerFactory<OtpBloc>(() => OtpBloc());
}
