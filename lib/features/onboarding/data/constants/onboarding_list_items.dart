import 'package:flutter/material.dart';
import 'package:pashboi/core/index.dart';
import 'package:pashboi/features/onboarding/data/models/onboarding_info.dart';

class OnboardingListItems {
  static List<OnboardingInfo> getListItems(BuildContext context) {
    return [
      OnboardingInfo(
        title: context.appLocalizations.onboarding_title_1,
        description: context.appLocalizations.onboarding_description_1,
        imagePath: "assets/images/onboarding/onboarding_one.jpg",
      ),
      OnboardingInfo(
        title: context.appLocalizations.onboarding_title_2,
        description: context.appLocalizations.onboarding_description_2,
        imagePath: "assets/images/onboarding/onboarding_two.jpg",
      ),
      OnboardingInfo(
        title: context.appLocalizations.onboarding_title_3,
        description: context.appLocalizations.onboarding_description_3,
        imagePath: "assets/images/onboarding/onboarding_three.jpg",
      ),
      OnboardingInfo(
        title: context.appLocalizations.onboarding_title_4,
        description: context.appLocalizations.onboarding_description_4,
        imagePath: "assets/images/onboarding/onboarding_four.jpg",
      ),
    ];
  }
}
