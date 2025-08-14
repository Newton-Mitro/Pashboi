import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/leave_type_blance_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/repositories/leave_type_blance_repositories_impl.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/leave_type_balance_repository.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_blance_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/leave_type_balance_bloc.dart';

void registerLeaveTypeBalanceModule() {
  // Register Data Sources
  sl.registerLazySingleton<LeaveTypeBalanceDataSource>(
    () => LeaveTypeBalanceDataSourceImpl(apiService: sl<ApiService>()),
  );
  // Register Repository
  sl.registerLazySingleton<LeaveTypeBalanceRepository>(
    () => LeaveTypeBalanceRepositoriesImpl(
      leaveTypeBalancedataSource: sl<LeaveTypeBalanceDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Register Use Cases
  sl.registerLazySingleton<LeaveTypeBalanceUseCase>(
    () => LeaveTypeBalanceUseCase(
      leaveTypeBalanceRepository: sl<LeaveTypeBalanceRepository>(),
    ),
  );

  sl.registerFactory<LeaveTypeBalanceBloc>(
    () => LeaveTypeBalanceBloc(
      leaveTypeBalanceUseCase: sl<LeaveTypeBalanceUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
