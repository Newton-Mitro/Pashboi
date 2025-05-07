import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/onboarding/domain/repositories/onboarding_info_repository.dart';

class GetOnboardingSeenUseCase extends UseCaseWithOutParams {
  final OnboardingInfoRepository repository;

  GetOnboardingSeenUseCase({required this.repository});

  @override
  ResultFuture<bool> call() {
    return repository.getOnboardingSeen();
  }
}
