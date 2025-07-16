import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/development_credits/data/data_sources/development_credit_data_source.dart';
import 'package:pashboi/features/public/development_credits/data/data_sources/local_datasource.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/domain/repositories/development_credits_repository.dart';

class DevelopmentCreditsRepositoryImpl implements DevelopmentCreditsRepository {
  final DevelopmentCreditRemoteDataSource developmentCreditRemoteDataSource;
  final DevelopmentCreditsLocalDataSource developmentCreditsLocalDataSource;
  final NetworkInfo networkInfo;

  DevelopmentCreditsRepositoryImpl({
    required this.developmentCreditRemoteDataSource,
    required this.developmentCreditsLocalDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<DevelopmentCreditsEntity>> getDevelopmentCredits() async {
    try {
      if (!await networkInfo.isConnected) {
        final localResult =
            await developmentCreditsLocalDataSource.fetchDevelopmentCredits();

        return Right(localResult);
      }
      final result =
          await developmentCreditRemoteDataSource.fetchDevelopmentData();

      await developmentCreditsLocalDataSource.storeDevelopmentCredits(result);

      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
