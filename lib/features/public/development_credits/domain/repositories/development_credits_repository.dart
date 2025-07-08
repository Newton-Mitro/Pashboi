import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';

abstract class DevelopmentCreditsRepository {
  ResultFuture<List<DevelopmentCreditsEntity>> getDevelopmentCredits();
}
