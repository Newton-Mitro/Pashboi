import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/usecases/fetch_agm_counter_info_usecase.dart';

abstract class AGMCounterRepository {
  ResultFuture<AGMCounterEntity> fetchAGMCounterInfo(
    FetchAGMCounterInfoProps props,
  );
}
