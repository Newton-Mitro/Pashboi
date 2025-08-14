import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/search_employee_entity.dart';

abstract class SearchEmployeeRepository {
  ResultFuture<List<SearchEmployeeEntity>> getSearchEmployee(props);
}
