import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveOnboardingInfo(bool showOnboarding);
  Future<bool> getOnboardingInfo();
  Future<void> clearOnboardingInfo();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final SharedPreferences prefs;
  OnboardingLocalDataSourceImpl(this.prefs);

  static const _onboardingKey = 'onboarding';

  @override
  Future<void> saveOnboardingInfo(bool showOnboarding) =>
      prefs.setBool(_onboardingKey, showOnboarding);

  @override
  Future<bool> getOnboardingInfo() =>
      Future.value(prefs.getBool(_onboardingKey) ?? false);

  @override
  Future<void> clearOnboardingInfo() => prefs.remove(_onboardingKey);
}
