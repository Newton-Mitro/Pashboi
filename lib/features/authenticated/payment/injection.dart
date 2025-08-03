import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/payment/presentation/pages/payment_page/bloc/payment_steps_bloc.dart';

void registerPaymentModule() async {
  // Register Data Sources
  // sl.registerLazySingleton<DepositRemoteDataSource>(
  //   () => DepositRemoteDataSourceImpl(apiService: sl<ApiService>()),
  // );

  // Register Repository
  // sl.registerLazySingleton<DepositRepository>(
  //   () => DepositRepositoryImpl(
  //     depositRemoteDataSource: sl<DepositRemoteDataSource>(),
  //     networkInfo: sl<NetworkInfo>(),
  //   ),
  // );

  // Register Use Cases
  // sl.registerLazySingleton<SubmitDepositNowUseCase>(
  //   () => SubmitDepositNowUseCase(depositRepository: sl<DepositRepository>()),
  // );

  // Register Bloc
  sl.registerFactory<PaymentStepsBloc>(
    () => PaymentStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
}
