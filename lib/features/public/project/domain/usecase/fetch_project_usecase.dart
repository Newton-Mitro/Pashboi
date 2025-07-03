import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';
import 'package:pashboi/features/public/project/domain/repositories/project_repository.dart';

class FetchProjectUseCase extends UseCase<List<ProjectEntity>, NoParams> {
  final ProjectRepository projectRepository;

  FetchProjectUseCase({required this.projectRepository});

  @override
  ResultFuture<List<ProjectEntity>> call(NoParams params) {
    return projectRepository.findProject();
  }
}
