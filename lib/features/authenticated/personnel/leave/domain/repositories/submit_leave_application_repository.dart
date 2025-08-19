import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/submit_leave_application_entity.dart';

abstract class SubmitLeaveApplicationRepository {
  ResultFuture<SubmitLeaveApplicationEntity> submitLeaveApplication(props);
}
