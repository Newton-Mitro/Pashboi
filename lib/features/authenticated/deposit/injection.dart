import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/bloc/deposit_now_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/otp_verification_section/bloc/otp_bloc.dart';

void registerDepositModule() async {
  // Register Data Sources
  // sl.registerLazySingleton<BeneficiaryRemoteDataSource>(
  //   () => BeneficiaryRemoteDataSourceImpl(apiService: sl<ApiService>()),
  // );

  // Register Repository
  // sl.registerLazySingleton<BeneficiaryRepository>(
  //   () => BeneficiaryRepositoryImpl(
  //     beneficiaryRemoteDataSource: sl<BeneficiaryRemoteDataSource>(),
  //     networkInfo: sl<NetworkInfo>(),
  //   ),
  // );

  // Register Use Cases
  // sl.registerLazySingleton<FetchBeneficiariesUseCase>(
  //   () => FetchBeneficiariesUseCase(
  //     beneficiaryRepository: sl<BeneficiaryRepository>(),
  //   ),
  // );

  // Register Bloc
  sl.registerFactory<DepositNowStepsBloc>(() => DepositNowStepsBloc());
  sl.registerFactory<OtpBloc>(() => OtpBloc());
}
