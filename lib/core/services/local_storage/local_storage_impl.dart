import 'package:shared_preferences/shared_preferences.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // ✅ Save Methods
  @override
  Future<void> saveString(String key, String value) async {
    final prefs = await _prefs;
    await prefs.setString(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    final prefs = await _prefs;
    await prefs.setInt(key, value);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(key, value);
  }

  @override
  Future<void> saveDouble(String key, double value) async {
    final prefs = await _prefs;
    await prefs.setDouble(key, value);
  }

  @override
  Future<void> saveStringList(String key, List<String> value) async {
    final prefs = await _prefs;
    await prefs.setStringList(key, value);
  }

  // ✅ Get Methods
  @override
  Future<String> getString(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  @override
  Future<int> getInt(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(key) ?? 0;
  }

  @override
  Future<bool> getBool(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key) ?? false;
  }

  @override
  Future<double> getDouble(String key) async {
    final prefs = await _prefs;
    return prefs.getDouble(key) ?? 0.0;
  }

  @override
  Future<List<String>> getStringList(String key) async {
    final prefs = await _prefs;
    return prefs.getStringList(key) ?? [];
  }

  // ✅ Remove Key
  @override
  Future<void> remove(String key) async {
    final prefs = await _prefs;
    await prefs.remove(key);
  }

  // ✅ Check if Key Exists
  @override
  Future<bool> containsKey(String key) async {
    final prefs = await _prefs;
    return prefs.containsKey(key);
  }
}
