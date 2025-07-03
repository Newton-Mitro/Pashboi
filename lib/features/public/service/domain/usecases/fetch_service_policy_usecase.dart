import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';
import 'package:pashboi/features/public/service/domain/repositories/service_policy_repository.dart';

class FetchServicePolicyProps {
  final String categoryId;

  FetchServicePolicyProps({required this.categoryId});
}

class FetchServicePolicyUseCase
    extends UseCase<List<ServicePolicyEntity>, FetchServicePolicyProps> {
  final ServicePolicyRepository servicePolicyRepository;

  FetchServicePolicyUseCase({required this.servicePolicyRepository});

  @override
  ResultFuture<List<ServicePolicyEntity>> call(
    FetchServicePolicyProps props,
  ) async {
    return servicePolicyRepository.findServicePoliciesByCategoryId(props);
  }
}
