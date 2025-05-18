import 'package:flutter/material.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/onboarding/domain/entities/onboarding_info_entity.dart';

abstract class OnboardingInfoRepository {
  ResultFuture setOnboardingSeen(bool seen);
  ResultFuture<bool> getOnboardingSeen();
  ResultFuture<List<OnboardingInfoEntity>> getOnboardingInfos(
    BuildContext context,
  );
}
