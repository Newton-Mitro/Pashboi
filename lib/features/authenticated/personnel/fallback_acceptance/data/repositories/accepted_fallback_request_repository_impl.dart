import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/datasource/accepted_fallback_request_remote_data_source.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/repositories/accepted_fallback_request_repository.dart';

class AcceptedFallbackRequestRepositoryImpl
    implements AcceptedFallbackRequestRepository {
  final AcceptedFallbackRequestRemoteDataSource
  acceptedFallbackRequestRemoteDataSource;
  final NetworkInfo networkInfo;

  AcceptedFallbackRequestRepositoryImpl({
    required this.acceptedFallbackRequestRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<String> getAcceptedFallbackRequest(params) async {
    try {
      final result = await acceptedFallbackRequestRemoteDataSource
          .acceptedFallback(params);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
