import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/withdraw/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/withdraw/domain/repositories/withdrawl_repository.dart';
import 'package:pashboi/features/authenticated/withdraw/domain/usecases/generate_withdrawl_qr_usecase.dart';

class WithdrawlRepositoryImpl implements WithdrawlRepository {
  final WithdrawlRemoteDataSource withdrawlRemoteDataSource;
  final NetworkInfo networkInfo;

  WithdrawlRepositoryImpl({
    required this.withdrawlRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<String> generateWithdrawlQr(
    GenerateWithdrawlQrProps params,
  ) async {
    try {
      final result = await withdrawlRemoteDataSource.generateWithdrawlQr(
        params,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
