import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

class DepositAccountRepositoryImpl implements DepositAccountRepository {
  final DepositAccountRemoteDataSource depositAccountRemoteDataSource;
  final NetworkInfo networkInfo;

  DepositAccountRepositoryImpl({
    required this.depositAccountRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<DepositAccountEntity>> getMyAccounts(
    GetMyAccountsProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.getMyAccounts(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<DepositAccountEntity> getAccountDetails(
    GetAccountDetailsProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.getAccountDetails(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
