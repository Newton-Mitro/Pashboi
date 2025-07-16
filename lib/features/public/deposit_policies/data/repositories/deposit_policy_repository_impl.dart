import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_policy_repository.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';

class DepositPolicyRepositoryImpl implements DepositPolicyRepository {
  final DepositPolicyRemoteDataSource depositPolicyRemoteDataSource;
  final DepositPolicyLocalDataSource depositPolicyLocalDataSource;
  final NetworkInfo networkInfo;

  DepositPolicyRepositoryImpl({
    required this.depositPolicyRemoteDataSource,
    required this.depositPolicyLocalDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<DepositPolicyEntity>> findDepositPoliciesByCategoryId(
    FetchPageProps props,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        final localResult = await depositPolicyLocalDataSource
            .fetchLoanPoliciesByCategoryId(props);

        return Right(localResult);
      }
      final result = await depositPolicyRemoteDataSource
          .fetchDepositPoliciesByCategoryId(props);
      await depositPolicyLocalDataSource.storeDepositPolicies(result);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
