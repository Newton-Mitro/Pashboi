import 'dart:convert';
import 'package:pashboi/features/public/project/data/models/project_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> fetchProject();
  Future<void> storeProject(List<ProjectModel> projects);
}

class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  final SharedPreferences sharedPreferences;
  final String projectData = 'project_data';

  ProjectLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final jsonString = sharedPreferences.getString(projectData);

      print("jsonString: $jsonString");
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => ProjectModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch loan policies from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeProject(List<ProjectModel> project) async {
    print("project: $project");
    final projectData = jsonEncode(
      project.map((e) => (e as dynamic).toJson()).toList(),
    );
    await sharedPreferences.setString(projectData, projectData);
  }
}
