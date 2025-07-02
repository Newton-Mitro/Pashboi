import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/datasources/relationship_remote_datasource.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/relationship_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/relationship_repository.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/fetch_relationships_usecase.dart';

class RelationshipRepositoryImpl implements RelationshipRepository {
  final RelationshipRemoteDataSource relationshipRemoteDataSource;
  final NetworkInfo networkInfo;

  RelationshipRepositoryImpl({
    required this.relationshipRemoteDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<List<RelationshipEntity>> fetchRelationships(
    FetchRelationshipsProps props,
  ) async {
    try {
      final result = await relationshipRemoteDataSource.fetchRelationships(
        props,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
