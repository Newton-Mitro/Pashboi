import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/pages/public/onboarding_page/data/models/onboarding_info.dart';

class OnboardingListItems {
  static List<OnboardingInfo> getListItems(BuildContext context) {
    return [
      OnboardingInfo(
        title: Locales.string(context, 'onboarding_title_1'),
        description: Locales.string(context, 'onboarding_description_1'),
        imagePath: "assets/images/onboarding/onboarding_one.jpg",
      ),
      OnboardingInfo(
        title: Locales.string(context, 'onboarding_title_2'),
        description: Locales.string(context, 'onboarding_description_2'),
        imagePath: "assets/images/onboarding/onboarding_two.jpg",
      ),
      OnboardingInfo(
        title: Locales.string(context, 'onboarding_title_3'),
        description: Locales.string(context, 'onboarding_description_3'),
        imagePath: "assets/images/onboarding/onboarding_three.jpg",
      ),
      OnboardingInfo(
        title: Locales.string(context, 'onboarding_title_4'),
        description: Locales.string(context, 'onboarding_description_4'),
        imagePath: "assets/images/onboarding/onboarding_four.jpg",
      ),
    ];
  }
}
