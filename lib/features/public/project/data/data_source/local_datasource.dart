import 'dart:convert';
import 'package:pashboi/features/public/project/data/models/project_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> fetchProject();
  Future<void> storeProject(List<ProjectModel> projects);
}

class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final String _projectPolicyKey = 'project_policy_key';

  ProjectLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<ProjectModel>> fetchProject() async {
    try {
      final jsonString = _sharedPreferences.getString(_projectPolicyKey);

      if (jsonString == null) throw Exception('Invalid response format');

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
    final projectData = jsonEncode(
      project.map((e) => (e as dynamic).toJson()).toList(),
    );
    await _sharedPreferences.setString(_projectPolicyKey, projectData);
  }
}
