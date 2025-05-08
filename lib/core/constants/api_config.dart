import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiUrl => dotenv.env['API_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get env => dotenv.env['FLUTTER_ENV'] ?? 'development';
}
