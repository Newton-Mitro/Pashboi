import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/data/data_sources/remote_datasource.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/domain/repositories/deposit_policy_repository.dart';
import 'package:pashboi/features/public/deposit_policies/domain/usecases/fetch_deposit_policy_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepositPolicyRepositoryImpl implements DepositPolicyRepository {
  final DepositPolicyRemoteDataSource depositPolicyRemoteDataSource;
  final DepositPolicyLocalDataSource depositPolicyLocalDataSource;
  final NetworkInfo networkInfo;
  final SharedPreferences sharedPreferences;

  DepositPolicyRepositoryImpl({
    required this.depositPolicyRemoteDataSource,
    required this.depositPolicyLocalDataSource,
    required this.networkInfo,
    required this.sharedPreferences,
  });

  @override
  ResultFuture<List<DepositPolicyEntity>> findDepositPoliciesByCategoryId(
    FetchPageProps props,
  ) async {
    try {
      if (!await networkInfo.isConnected) {
        final localResult = await depositPolicyLocalDataSource
            .fetchDepositPoliciesByCategoryId(props);

        // if (localResult.isEmpty) {
        //   return Left(FailureMapper.fromException(NoCacheFailure()));
        // }

        return Right(localResult);
      }
      final result = await depositPolicyRemoteDataSource
          .fetchDepositPoliciesByCategoryId(props);

      final depositPolicyData = jsonEncode(
        result.map((e) => (e as dynamic).toJson()).toList(),
      );
      await sharedPreferences.setString(props.toString(), depositPolicyData);

      // final cachedJson = sharedPreferences.getString("depositPolicy");

      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
