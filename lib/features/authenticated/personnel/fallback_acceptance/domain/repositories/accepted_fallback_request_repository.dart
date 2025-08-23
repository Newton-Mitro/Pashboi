import 'package:pashboi/core/types/typedef.dart';

abstract class AcceptedFallbackRequestRepository {
  ResultFuture<String> getAcceptedFallbackRequest(props);
}
