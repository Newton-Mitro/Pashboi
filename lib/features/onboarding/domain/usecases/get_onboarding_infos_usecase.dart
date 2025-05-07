import 'package:flutter/widgets.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/onboarding/domain/entities/onboarding_info_entity.dart';
import 'package:pashboi/features/onboarding/domain/repositories/onboarding_info_repository.dart';

final class GetOnboardingInfosParams {
  final BuildContext context;

  GetOnboardingInfosParams({required this.context});
}

class GetOnboardingInfosUseCase
    extends UseCase<List<OnboardingInfoEntity>, GetOnboardingInfosParams> {
  final OnboardingInfoRepository repository;

  GetOnboardingInfosUseCase({required this.repository});

  @override
  ResultFuture<List<OnboardingInfoEntity>> call({
    GetOnboardingInfosParams? params,
  }) {
    return repository.getOnboardingInfos(params!.context);
  }
}
