import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/public/service_centers/domain/entites/service_center_entity.dart';

abstract class ServiceCenterRepository {
  ResultFuture<List<ServiceCenterEntity>> findAllServiceCenter();
}
