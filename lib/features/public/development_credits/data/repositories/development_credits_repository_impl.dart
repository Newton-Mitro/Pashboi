import 'package:dartz/dartz.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/public/development_credits/data/data_sources/development_credit_data_source.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/domain/repositories/development_credits_repository.dart';

class DevelopmentCreditsRepositoryImpl implements DevelopmentCreditsRepository {
  final DevelopmentCreditDataSource developmentCreditDataSource;
  final NetworkInfo networkInfo;

  DevelopmentCreditsRepositoryImpl({
    required this.developmentCreditDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<DevelopmentCreditsEntity>> getDevelopmentCredits() async {
    try {
      if (!await networkInfo.isConnected) {
        return Left(FailureMapper.fromException(NoInternetFailure()));
      }
      final result = await developmentCreditDataSource.fetchDevelopmentData();
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
