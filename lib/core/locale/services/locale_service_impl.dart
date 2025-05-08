import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/core/locale/services/locale_service.dart';

class LocaleServiceImpl implements LocaleService {
  final LocalStorage localStorage;

  LocaleServiceImpl(this.localStorage);

  @override
  Future<String> getLocale() async {
    final locale = await localStorage.getString(StorageKey.keyLocale);
    return locale ?? 'en';
  }

  @override
  Future<void> setLocale(String locale) async {
    await localStorage.saveString(StorageKey.keyLocale, locale);
  }
}
