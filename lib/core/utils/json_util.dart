import 'dart:convert';

class JsonUtil {
  /// Convert a single model to JSON string
  static String encodeModel(Map<String, dynamic> model) {
    return jsonEncode(model);
  }

  /// Convert a list of models to JSON string
  static String encodeModelList(List<Map<String, dynamic>> models) {
    return jsonEncode(models);
  }

  /// Decode JSON string to Map (single model)
  static Map<String, dynamic> decodeModel(String jsonString) {
    return jsonDecode(jsonString);
  }

  /// Decode JSON string to List of Maps (model list)
  static List<Map<String, dynamic>> decodeModelList(String jsonString) {
    return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  }
}
