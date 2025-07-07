import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_loans/data/repositories/loan_repository.impl.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/repositories/loan_repository.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_my_loans_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_details_page/bloc/loan_details_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/bloc/loan_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/my_loans_page/bloc/my_loans_bloc.dart';

void registerLoanModule() async {
  // Register Data Sources
  sl.registerLazySingleton<LoanRemoteDataSource>(
    () => LoanRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<LoanRepository>(
    () => LoanRepositoryImpl(
      loanRemoteDataSource: sl<LoanRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<FetchMyLoansUseCase>(
    () => FetchMyLoansUseCase(loanRepository: sl<LoanRepository>()),
  );

  sl.registerLazySingleton<FetchLoanStatementUseCase>(
    () => FetchLoanStatementUseCase(loanRepository: sl<LoanRepository>()),
  );

  sl.registerLazySingleton<FetchLoanDetailsUseCase>(
    () => FetchLoanDetailsUseCase(loanRepository: sl<LoanRepository>()),
  );

  // Register Bloc
  sl.registerFactory<MyLoansBloc>(
    () => MyLoansBloc(
      fetchMyLoansUseCase: sl<FetchMyLoansUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );

  sl.registerFactory<LoanDetsilsBloc>(
    () => LoanDetsilsBloc(
      fetchLoanDetailsUseCase: sl<FetchLoanDetailsUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );

  sl.registerFactory<LoanStatementBloc>(
    () => LoanStatementBloc(
      fetchLoanStatementUseCase: sl<FetchLoanStatementUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
