import 'dart:convert';
import 'package:pashboi/features/public/development_credits/data/models/development_credits_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DevelopmentCreditsLocalDataSource {
  Future<List<DevelopmentCreditsModel>> fetchDevelopmentCredits();
  Future<void> storeDevelopmentCredits(List<DevelopmentCreditsModel> credits);
}

class DevelopmentCreditsLocalDataSourceImpl
    implements DevelopmentCreditsLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final String _developmentCreditsKey = 'development_credits_key';

  DevelopmentCreditsLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<DevelopmentCreditsModel>> fetchDevelopmentCredits() async {
    try {
      final jsonString = _sharedPreferences.getString(_developmentCreditsKey);

      if (jsonString == null) throw Exception('Invalid response format');

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map(
            (e) => DevelopmentCreditsModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch development credits from local data source: $e',
      );
    }
  }

  @override
  Future<void> storeDevelopmentCredits(
    List<DevelopmentCreditsModel> credits,
  ) async {
    final creditsData = jsonEncode(
      credits.map((e) => (e as dynamic).toJson()).toList(),
    );
    await _sharedPreferences.setString(_developmentCreditsKey, creditsData);
  }
}
