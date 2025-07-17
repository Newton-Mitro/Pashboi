import 'dart:convert';
import 'package:pashboi/features/public/notice/data/models/notice_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NoticeLocalDataSource {
  Future<List<NoticeModel>> fetchNoticeByCategoryId();
  Future<void> StoreNotice(List<NoticeModel> notices);
}

class NoticeLocalDataSourceImpl implements NoticeLocalDataSource {
  final SharedPreferences _sharedPreferences;
  final String _noticePolicyKey = 'Notice_policy_key';

  NoticeLocalDataSourceImpl(this._sharedPreferences);

  @override
  Future<List<NoticeModel>> fetchNoticeByCategoryId() async {
    try {
      final jsonString = _sharedPreferences.getString(_noticePolicyKey);
      if (jsonString == null) throw Exception('Invalid response format');

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception(
        'Failed to fetch loan policies from local data source: $e',
      );
    }
  }

  @override
  Future<void> StoreNotice(List<NoticeModel> notices) async {
    final noticeData = jsonEncode(
      notices.map((e) => (e as dynamic).toJson()).toList(),
    );
    await _sharedPreferences.setString(_noticePolicyKey, noticeData);
  }
}
