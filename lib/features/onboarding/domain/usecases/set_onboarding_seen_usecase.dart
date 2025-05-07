import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/onboarding/domain/repositories/onboarding_info_repository.dart';

final class SetOnboardingSeenParams {
  final bool seen;

  SetOnboardingSeenParams({required this.seen});
}

class SetOnboardingSeenUseCase extends UseCase<void, SetOnboardingSeenParams> {
  final OnboardingInfoRepository repository;

  SetOnboardingSeenUseCase({required this.repository});

  @override
  ResultVoid call({SetOnboardingSeenParams? params}) {
    return repository.setOnboardingSeen(params!.seen);
  }
}
