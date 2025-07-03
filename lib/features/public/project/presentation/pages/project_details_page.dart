import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ProjectDetailsPage extends StatelessWidget {
  final ProjectEntity project;

  const ProjectDetailsPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = project.attachmentUrl;
    final bool showIcon = imageUrl.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Project Details'), elevation: 0),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon
                  ? Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: double.infinity,
                    child: FaIcon(
                      FontAwesomeIcons.fileContract,
                      size: 100,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                  )
                  : Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              Html(data: project.longDescription),
            ],
          ),
        ),
      ),
    );
  }
}
