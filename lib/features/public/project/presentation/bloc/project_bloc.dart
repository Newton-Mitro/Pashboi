import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';
import 'package:pashboi/features/public/project/domain/usecase/fetch_project_usecase.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final FetchProjectUseCase projectUseCase;

  ProjectBloc({required this.projectUseCase}) : super(ProjectInitial()) {
    on<ProjectEvent>((event, emit) async {
      emit(ProjectLoading());

      final dataState = await projectUseCase.call(NoParams());
      dataState.fold(
        (failure) {
          emit(ProjectError(error: failure.message));
        },
        (projects) {
          emit(ProjectSuccess(projects: projects));
        },
      );
    });
  }
}
