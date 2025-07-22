import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/deposit/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/deposit/domain/repositories/deposit_repository.dart';
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
}
