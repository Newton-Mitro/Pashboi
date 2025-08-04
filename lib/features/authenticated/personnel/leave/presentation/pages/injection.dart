import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/datasource/leave_type_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/repositories/leave_type_repositories_impl.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/repositories/leave_type_repository.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_usecase.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/leave_type_bloc.dart';

void registerLeaveTypeModule() {
  // Register Data Sources
  sl.registerLazySingleton<LeaveTypeRemoteDataSource>(
    () => LeaveTypeRemoteDataSourceImpl(apiService: sl<ApiService>()),
  );

  // Register Repository
  sl.registerLazySingleton<LeaveTypeRepository>(
    () => LeaveTypeRepositoryImpl(
      leaveTypeDataSource: sl<LeaveTypeRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  // Register Use Cases
  sl.registerLazySingleton<LeaveTypeUseCase>(
    () => LeaveTypeUseCase(leaveTypeRepository: sl<LeaveTypeRepository>()),
  );
  // Register Bloc
  sl.registerFactory<LeaveTypeBloc>(
    () => LeaveTypeBloc(
      leaveTypeUseCase: sl<LeaveTypeUseCase>(),
      getAuthUserUseCase: sl<GetAuthUserUseCase>(),
    ),
  );
}
