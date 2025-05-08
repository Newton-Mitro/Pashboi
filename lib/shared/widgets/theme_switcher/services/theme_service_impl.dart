import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/shared/widgets/theme_switcher/services/theme_service.dart';

class ThemeServiceImpl implements ThemeService {
  final LocalStorage localStorage;

  ThemeServiceImpl(this.localStorage);

  @override
  Future<String> getTheme() async {
    final theme = await localStorage.getString(StorageKey.keyTheme);
    return theme ?? 'light';
  }

  @override
  Future<void> setTheme(String theme) async {
    await localStorage.saveString(StorageKey.keyTheme, theme);
  }
}
