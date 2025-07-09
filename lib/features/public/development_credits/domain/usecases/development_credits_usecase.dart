import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/domain/repositories/development_credits_repository.dart';

class DevelopmentCreditsUseCase
    extends UseCase<List<DevelopmentCreditsEntity>, NoParams> {
  final DevelopmentCreditsRepository developmentCreditsRepository;

  DevelopmentCreditsUseCase({required this.developmentCreditsRepository});

  @override
  ResultFuture<List<DevelopmentCreditsEntity>> call(NoParams params) async {
    return developmentCreditsRepository.getDevelopmentCredits();
  }
}
