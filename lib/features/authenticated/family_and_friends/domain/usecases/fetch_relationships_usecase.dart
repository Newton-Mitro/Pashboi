import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/entities/relationship_entity.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/repositories/relationship_repository.dart';

class FetchRelationshipsProps extends BaseRequestProps {
  final String gender;

  const FetchRelationshipsProps({
    required this.gender,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class FetchRelationshipsUseCase
    extends UseCase<List<RelationshipEntity>, FetchRelationshipsProps> {
  final RelationshipRepository relationshipRepository;

  FetchRelationshipsUseCase({required this.relationshipRepository});

  @override
  ResultFuture<List<RelationshipEntity>> call(
    FetchRelationshipsProps props,
  ) async {
    return relationshipRepository.fetchRelationships(props);
  }
}
