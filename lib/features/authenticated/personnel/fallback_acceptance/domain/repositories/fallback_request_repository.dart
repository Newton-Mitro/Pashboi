import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/domain/entities/fallback_leave_application_entites.dart';

abstract class FallbackRequestRepository {
  ResultFuture<List<FallbackLeaveApplicationEntities>> getFallbackRequest(
    props,
  );
}
