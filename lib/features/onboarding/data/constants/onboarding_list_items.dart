import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/constants/app_images.dart';
import 'package:pashboi/features/onboarding/data/models/onboarding_info.dart';

class OnboardingListItems {
  static List<OnboardingInfoModel> getListItems(BuildContext context) {
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
