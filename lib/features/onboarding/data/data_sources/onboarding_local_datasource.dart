import 'package:flutter/widgets.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';
import 'package:pashboi/features/onboarding/data/models/onboarding_info.dart';
import 'package:pashboi/core/constants/app_images.dart';

abstract class OnboardingLocalDataSource {
  Future<void> setOnboardingSeen(bool seen);
  Future<bool> hasSeenOnboarding();
  Future<List<OnboardingInfoModel>> getOnboardingInfos(BuildContext context);
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final LocalStorage localStorage;

  OnboardingLocalDataSourceImpl({required this.localStorage});

  static const _onboardingKey = 'onboarding_seen';

  @override
  Future<void> setOnboardingSeen(bool seen) async {
    await localStorage.saveBool(_onboardingKey, seen);
  }

  @override
  Future<bool> hasSeenOnboarding() async {
    return localStorage.getBool(_onboardingKey);
  }

  @override
  Future<List<OnboardingInfoModel>> getOnboardingInfos(
    BuildContext context,
  ) async {
    return [
      OnboardingInfoModel(
        title: Locales.string(context, 'onboarding_title_1'),
        description: Locales.string(context, 'onboarding_description_1'),
        imagePath: AppImages.pathOnboarding1,
      ),
      OnboardingInfoModel(
        title: Locales.string(context, 'onboarding_title_2'),
        description: Locales.string(context, 'onboarding_description_2'),
        imagePath: AppImages.pathOnboarding2,
      ),
      OnboardingInfoModel(
        title: Locales.string(context, 'onboarding_title_3'),
        description: Locales.string(context, 'onboarding_description_3'),
        imagePath: AppImages.pathOnboarding3,
      ),
      OnboardingInfoModel(
        title: Locales.string(context, 'onboarding_title_4'),
        description: Locales.string(context, 'onboarding_description_4'),
        imagePath: AppImages.pathOnboarding4,
      ),
    ];
  }
}
