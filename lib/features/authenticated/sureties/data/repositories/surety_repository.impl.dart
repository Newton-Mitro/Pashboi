import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/sureties/data/datasources/remote.datasource.dart';
import 'package:pashboi/features/authenticated/sureties/domain/entities/surety_entity.dart';
import 'package:pashboi/features/authenticated/sureties/domain/repositories/surety_repository.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_given_sureties_usecase.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_loan_sureties_usecase.dart';

class SuretyRepositoryImpl implements SuretyRepository {
  final SuretyRemoteDataSource suretyRemoteDataSource;
  final NetworkInfo networkInfo;

  SuretyRepositoryImpl({
    required this.suretyRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<SuretyEntity>> fetchGivenSureties(
    FetchGivenSuretiesProps props,
  ) async {
    try {
      final result = await suretyRemoteDataSource.fetchGivenSureties(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<SuretyEntity>> fetchLoanSureties(
    FetchLoanSuretiesProps props,
  ) async {
    try {
      final result = await suretyRemoteDataSource.fetchLoanSureties(props);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
