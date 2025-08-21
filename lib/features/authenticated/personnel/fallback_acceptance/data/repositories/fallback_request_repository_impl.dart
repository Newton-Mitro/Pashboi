import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/datasource/fallback_request_remote_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/model/fallback_request_model.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/repositories/fallback_request_repository.dart';

class FallbackRequestRepositoryImpl implements FallbackRequestRepository {
  final FallbackRequestRemoteDataSource datasourceVarName;
  final NetworkInfo networkInfo;

  FallbackRequestRepositoryImpl({
    required this.datasourceVarName,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<FallbackRequestModel>> getFallbackRequest(params) async {
    try {
      final result = await datasourceVarName.fetchFallbackRequest(params);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
