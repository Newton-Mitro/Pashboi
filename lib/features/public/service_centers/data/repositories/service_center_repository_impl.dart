import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/service_centers/data/data_source/remort_service_center_datasource.dart';
import 'package:pashboi/features/public/service_centers/domain/entites/service_center_entity.dart';
import 'package:pashboi/features/public/service_centers/domain/repositories/service_center_repository.dart';

class ServiceCenterRepositoryImpl implements ServiceCenterRepository {
  final ServiceCenterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ServiceCenterRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<ServiceCenterEntity>> findAllServiceCenter() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(FailureMapper.fromException(NoInternetFailure()));
      }
      final result = await remoteDataSource.findAllServiceCenters();
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
