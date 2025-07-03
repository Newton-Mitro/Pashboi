import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';

abstract class ProjectRepository {
  ResultFuture<List<ProjectEntity>> findProject();
}
