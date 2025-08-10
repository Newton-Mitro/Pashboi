import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/deposit/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/bkash_payment_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/entities/voucher_entity.dart';
import 'package:pashboi/features/authenticated/deposit/domain/repositories/deposit_repository.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/fetch_bkash_service_charge_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/fetch_scheduled_deposits_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_from_bkash_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_later_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';

class DepositRepositoryImpl implements DepositRepository {
  final DepositRemoteDataSource depositRemoteDataSource;
  final NetworkInfo networkInfo;

  DepositRepositoryImpl({
    required this.depositRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<String> submitDepositNow(SubmitDepositNowProps props) async {
    try {
      final result = await depositRemoteDataSource.submitDepositNow(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> submitDepositLater(SubmitDepositLaterProps props) async {
    try {
      final result = await depositRemoteDataSource.submitDepositLater(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<BkashPaymentEntity> submitDepositFromBkash(
    SubmitDepositFromBkashProps props,
  ) async {
    try {
      final result = await depositRemoteDataSource.submitDepositFromBkash(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<double> fetchBkashServiceCharge(
    FetchBkashServiceChargeProps props,
  ) async {
    try {
      final result = await depositRemoteDataSource.fetchBkashServiceCharge(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<DepositRequestEntity>> fetchScheduledDeposits(
    FetchScheduledDepositsProps props,
  ) async {
    try {
      final result = await depositRemoteDataSource.fetchScheduledDeposits(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
