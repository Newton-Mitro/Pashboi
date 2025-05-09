import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/my_app/domain/entities/app_status_entity.dart';
import 'package:pashboi/features/my_app/domain/repositories/app_status_repository.dart';

class FetchAppStatusUseCase implements UseCase<AppStatusEntity, NoParams> {
  final AppStatusRepository repository;

  FetchAppStatusUseCase(this.repository);

  @override
  ResultFuture<AppStatusEntity> call(NoParams params) async {
    return await repository.fetchAppStatus();
  }
}
