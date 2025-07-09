import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';
import 'package:pashboi/features/public/project/presentation/bloc/project_bloc.dart';
import 'package:pashboi/features/public/project/presentation/pages/project_details_page.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ProjectPage extends StatelessWidget {
  const ProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => sl<ProjectBloc>()..add(FetchProjectEvent()),
        child: PageContainer(
          child: BlocBuilder<ProjectBloc, ProjectState>(
            builder: (context, state) {
              if (state is ProjectLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProjectError) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is ProjectSuccess) {
                final List<ProjectEntity> projects = state.projects;

                if (projects.isEmpty) {
                  return const Center(child: Text('No projects available.'));
                }

                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Card(
                      elevation: 1,
                      shadowColor: const Color.fromARGB(179, 0, 0, 0),
                      surfaceTintColor: context.theme.colorScheme.surface,
                      color: context.theme.colorScheme.surface,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(project.attachmentUrl),
                          radius: 20,
                          // backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          project.title,
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ), // or project.title, depending on your entity
                        subtitle: Text(
                          project.shortDescription ?? '',
                          style: TextStyle(
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ), // if it exists
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      ProjectDetailsPage(project: project),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
