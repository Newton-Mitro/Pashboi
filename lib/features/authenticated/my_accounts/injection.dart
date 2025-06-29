import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/repositories/deposit_account_repository.impl.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_details_page/bloc/account_details_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/my_account_page/bloc/my_account_bloc.dart';

void registerMyAccountsModule() async {
  // Register Data Sources
  sl.registerLazySingleton<DepositAccountRemoteDataSource>(
    () => DepositAccountRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<DepositAccountRepository>(
    () => DepositAccountRepositoryImpl(
      depositAccountRemoteDataSource: sl<DepositAccountRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<GetMyAccountsUseCase>(
    () => GetMyAccountsUseCase(
      depositAccountRepository: sl<DepositAccountRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<AccountOpeningStepsBloc>(() => AccountOpeningStepsBloc());

  sl.registerFactory<MyAccountBloc>(
    () => MyAccountBloc(
      getMyAccountsUseCase: sl<GetMyAccountsUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );

  sl.registerFactory<AccountDetailsBloc>(
    () => AccountDetailsBloc(
      getAccountDetailsUseCase: sl<GetAccountDetailsUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
