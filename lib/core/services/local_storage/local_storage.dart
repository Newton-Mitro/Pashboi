abstract class LocalStorage {
  // ✅ Save Data
  Future<void> saveString(String key, String value);
  Future<void> saveInt(String key, int value);
  Future<void> saveBool(String key, bool value);
  Future<void> saveDouble(String key, double value);
  Future<void> saveStringList(String key, List<String> value);

  // ✅ Get Data
  Future<String> getString(String key);
  Future<int> getInt(String key);
  Future<bool> getBool(String key);
  Future<double> getDouble(String key);
  Future<List<String>> getStringList(String key);

  // ✅ Remove & Check Key
  Future<void> remove(String key);
  Future<bool> containsKey(String key);
}
