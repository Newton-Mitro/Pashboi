import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/services/network/product_api_service.dart';
import 'package:pashboi/features/public/loan_policies/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/loan_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/loan_policies/data/repositories/loan_policy_repository_impl.dart';
import 'package:pashboi/features/public/loan_policies/domain/repositories/loan_policy_repository.dart';
import 'package:pashboi/features/public/loan_policies/domain/usecases/fetch_loan_policy_usecase.dart';
import 'package:pashboi/features/public/loan_policies/presentation/bloc/loan_policy_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void registerLoanPolicyModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  // Register Data Sources
  sl.registerLazySingleton<LoanPolicyRemoteDataSource>(
    () => LoanPolicyRemoteDataSourceImpl(
      productApiService: sl<ProductApiService>(),
    ),
  );

  sl.registerLazySingleton<LoanPolicyLocalDataSource>(
    () => LoanPolicyLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  // Register Repository
  sl.registerLazySingleton<LoanPolicyRepository>(
    () => LoanPolicyRepositoryImpl(
      loanPolicyRemoteDataSource: sl<LoanPolicyRemoteDataSource>(),
      loanPolicyLocalDataSource: sl<LoanPolicyLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FetchLoanPolicyUseCase>(
    () => FetchLoanPolicyUseCase(
      loanPolicyRepository: sl<LoanPolicyRepository>(),
    ),
  );

  // Register Bloc
  sl.registerFactory<LoanPolicyBloc>(
    () => LoanPolicyBloc(fetchLoanPolicyUseCase: sl<FetchLoanPolicyUseCase>()),
  );
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}
