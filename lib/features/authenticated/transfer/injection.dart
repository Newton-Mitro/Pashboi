import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/bank_to_dc_transfer_page/bloc/bank_to_dc_transfer_steps_bloc.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/internal_transfer_page/bloc/internal_transfer_steps_bloc.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/bloc/transfer_to_bkash_steps_bloc.dart';

void registerTransferModule() async {
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
  sl.registerFactory<BankToDcTransferStepsBloc>(
    () => BankToDcTransferStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
  sl.registerFactory<InternalTransferStepsBloc>(
    () => InternalTransferStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
  sl.registerFactory<TransferToBkashStepsBloc>(
    () => TransferToBkashStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitDepositNowUseCase: sl<SubmitDepositNowUseCase>(),
    ),
  );
}
