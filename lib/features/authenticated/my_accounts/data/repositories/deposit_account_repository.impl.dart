import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/datasources/deposit_account_remote.datasource.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/account_transaction_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/repositories/deposit_account_repository.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/add_operating_account_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_dependents_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_operating_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/open_deposit_account_usecase.dart';

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

  @override
  ResultFuture<List<AccountTransactionEntity>> getAccountStatement(
    GetAccountStatementProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.getAccountStatement(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> addOperatingAccount(
    AddOperatingAccountProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.addOperatingAccount(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<DepositAccountEntity>> fetchDependents(
    FetchDependentsProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.fetchDependents(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<DepositAccountEntity>> fetchOperatingAccounts(
    FetchOperatingAccountsProps props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource
          .fetchOperatingAccounts(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> openDepositAccount(
    OpenDepositAccountParams props,
  ) async {
    try {
      final result = await depositAccountRemoteDataSource.openDepositAccount(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
