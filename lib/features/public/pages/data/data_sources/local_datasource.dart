import 'dart:convert';
import 'package:pashboi/features/public/pages/data/models/page_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Interface for local page data source
abstract class PageLocalDataSource {
  Future<PageModel?> fetchPage(String slug);
  Future<void> storePage(PageModel page, String slug);
}

/// Implementation using SharedPreferences
class PageLocalDataSourceImpl implements PageLocalDataSource {
  final SharedPreferences _sharedPreferences;

  PageLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<PageModel?> fetchPage(String slug) async {
    try {
      final jsonString = _sharedPreferences.getString(slug);

      if (jsonString == null) throw Exception('Invalid response format');

      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return PageModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to fetch page from local data source: $e');
    }
  }

  @override
  Future<void> storePage(PageModel page, String slug) async {
    final String pageData = jsonEncode(page.toJson());

    await _sharedPreferences.setString(slug, pageData);
  }
}
