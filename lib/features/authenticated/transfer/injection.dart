import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/transfer/data/repositories/transfer_repository.impl.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_fund_transfer_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_transfer_bank_to_dc_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_transfer_to_bkash_usecase.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/bank_to_dc_transfer_page/bloc/bank_to_dc_transfer_steps_bloc.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/internal_transfer_page/bloc/internal_transfer_steps_bloc.dart';
import 'package:pashboi/features/authenticated/transfer/presentation/pages/transfer_to_bkash_page/bloc/transfer_to_bkash_steps_bloc.dart';

void registerTransferModule() async {
  // Register Data Sources
  sl.registerLazySingleton<TransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(
      transferRemoteDataSource: sl<TransferRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<SubmitFundTransferUseCase>(
    () =>
        SubmitFundTransferUseCase(transferRepository: sl<TransferRepository>()),
  );
  sl.registerLazySingleton<SubmitTransferToBkashUseCase>(
    () => SubmitTransferToBkashUseCase(
      transferRepository: sl<TransferRepository>(),
    ),
  );
  sl.registerLazySingleton<SubmitTransferBankToDcUseCase>(
    () => SubmitTransferBankToDcUseCase(
      transferRepository: sl<TransferRepository>(),
    ),
  );

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
      submitFundTransferUseCase: sl<SubmitFundTransferUseCase>(),
    ),
  );
  sl.registerFactory<TransferToBkashStepsBloc>(
    () => TransferToBkashStepsBloc(
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
      submitTransferToBkashUseCase: sl<SubmitTransferToBkashUseCase>(),
    ),
  );
}
