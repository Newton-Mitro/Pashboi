import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/transfer/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/transfer/domain/repositories/transfer_repository.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_fund_transfer_usecase.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSource transferRemoteDataSource;
  final NetworkInfo networkInfo;

  TransferRepositoryImpl({
    required this.transferRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<String> submitFundTransfer(
    SubmitFundTransferProps params,
  ) async {
    try {
      final result = await transferRemoteDataSource.submitFundTransfer(params);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
