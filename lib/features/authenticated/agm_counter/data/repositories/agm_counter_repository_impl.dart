import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/agm_counter/data/datasources/agm_counter_remote_datasource.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/repositories/agm_counter_repository.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/usecases/fetch_agm_counter_info_usecase.dart';

class AGMCounterRepositoryImpl implements AGMCounterRepository {
  final AGMCounterRemoteDataSource agmCounterRemoteDataSource;
  final NetworkInfo networkInfo;

  AGMCounterRepositoryImpl({
    required this.agmCounterRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<AGMCounterEntity> fetchAGMCounterInfo(
    FetchAGMCounterInfoProps params,
  ) async {
    try {
      final result = await agmCounterRemoteDataSource.fetchAGMCounterInfo(
        params,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
