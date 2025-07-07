import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/public/service_centers/domain/entites/service_center_entity.dart';
import 'package:pashboi/features/public/service_centers/domain/repositories/service_center_repository.dart';

class FetchServiceCenterUseCase
    extends UseCase<List<ServiceCenterEntity>, NoParams> {
  final ServiceCenterRepository serviceCenterRepository;

  FetchServiceCenterUseCase({required this.serviceCenterRepository});

  @override
  ResultFuture<List<ServiceCenterEntity>> call(NoParams params) {
    return serviceCenterRepository.findAllServiceCenter();
  }
}
