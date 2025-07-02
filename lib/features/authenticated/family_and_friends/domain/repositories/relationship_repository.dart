import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/relationship_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/fetch_relationships_usecase.dart';

abstract class RelationshipRepository {
  ResultFuture<List<RelationshipEntity>> fetchRelationships(
    FetchRelationshipsProps props,
  );
}
