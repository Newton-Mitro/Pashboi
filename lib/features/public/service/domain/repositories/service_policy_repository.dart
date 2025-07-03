import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';
import 'package:pashboi/features/public/service/domain/usecases/fetch_service_policy_usecase.dart';

abstract class ServicePolicyRepository {
  ResultFuture<List<ServicePolicyEntity>> findServicePoliciesByCategoryId(
    FetchServicePolicyProps props,
  );
}
