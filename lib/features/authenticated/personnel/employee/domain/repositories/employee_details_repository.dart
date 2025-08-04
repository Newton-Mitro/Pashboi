import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/employee/domain/entities/employee_details_entity.dart';
import 'package:pashboi/features/authenticated/personnel/employee/domain/usecase/employee_details_usecase.dart';

abstract class EmployeeDetailsRepository {
  ResultFuture<EmployeeDetailsEntity> getEmployeeDetails(
    EmployeeDetailsProps props,
  );
}
