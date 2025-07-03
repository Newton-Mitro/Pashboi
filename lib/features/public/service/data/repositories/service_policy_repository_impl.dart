import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/service/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';
import 'package:pashboi/features/public/service/domain/repositories/service_policy_repository.dart';
import 'package:pashboi/features/public/service/domain/usecases/fetch_service_policy_usecase.dart';

class ServicePolicyRepositoryImpl implements ServicePolicyRepository {
  final ServicePolicyRemoteDataSource servicePolicyRemoteDataSource;
  final NetworkInfo networkInfo;

  ServicePolicyRepositoryImpl({
    required this.servicePolicyRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<ServicePolicyEntity>> findServicePoliciesByCategoryId(
    FetchServicePolicyProps props,
  ) async {
    try {
      final result = await servicePolicyRemoteDataSource
          .fetchServicePoliciesByCategoryId(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
