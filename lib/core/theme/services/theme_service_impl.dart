import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/core/theme/services/theme_service.dart';

class ThemeServiceImpl implements ThemeService {
  final LocalStorage localStorage;
  static const keyTheme = 'keyTheme';

  ThemeServiceImpl(this.localStorage);

  @override
  Future<String> getTheme() async {
    final theme = await localStorage.getString(keyTheme);
    return theme;
  }

  @override
  Future<void> setTheme(String theme) async {
    await localStorage.saveString(keyTheme, theme);
  }
}
