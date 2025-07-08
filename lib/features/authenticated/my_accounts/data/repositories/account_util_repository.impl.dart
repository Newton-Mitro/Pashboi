import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/datasources/account_util_remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/openable_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_amount_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/tenure_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/account_util_repository.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenure_amounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenures_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_openable_accounts_usecase.dart';

class AccountUtilRepositoryImpl implements AccountUtilRepository {
  final AccountUtilRemoteDataSource accountUtilRemoteDataSource;
  final NetworkInfo networkInfo;

  AccountUtilRepositoryImpl({
    required this.accountUtilRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<OpenableAccountEntity>> fetchOpenableAccounts(
    FetchOpenableAccountsProps props,
  ) async {
    try {
      final result = await accountUtilRemoteDataSource.fetchOpenableAccounts(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<TenureAmountEntity>> fetchAccountTenureAmounts(
    FetchAccountTenureAmountsProps props,
  ) async {
    try {
      final result = await accountUtilRemoteDataSource
          .fetchAccountTenureAmounts(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<TenureEntity>> fetchAccountTenures(
    FetchAccountTenuresProps props,
  ) async {
    try {
      final result = await accountUtilRemoteDataSource.fetchAccountTenures(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
