import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/deposit_product_local_data_source.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/deposit_product_remote_data_source.dart';
import 'package:pashboi/features/public/deposit_policies/data/repositories/deposit_product_repository_impl.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_product_repository.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/get_deposit_product.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/bloc/deposit_product_bloc.dart';

Future<void> initializeDepositPolices() async {
  sl.registerSingleton<DepositProductRemoteDataSource>(
    DepositProductRemoteDataSource(apiService: sl<ApiService>()),
  );

  sl.registerSingleton<DepositProductRepository>(
    DepositProductRepositoryImpl(
      depositProductRemoteDataSource: sl<DepositProductRemoteDataSource>(),
      depositProductLocalDataSource: sl<DepositProductLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  sl.registerSingleton<GetDepositProductUseCase>(
    GetDepositProductUseCase(
      depositProductRepository: sl<DepositProductRepository>(),
    ),
  );

  sl.registerFactory<DepositProductBloc>(
    () => DepositProductBloc(
      getDepositProductUseCase: sl<GetDepositProductUseCase>(),
    ),
  );
}
