import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/submit_leave_application_entity.dart';

class SubmitLeaveApplicationModel extends SubmitLeaveApplicationEntity {
  SubmitLeaveApplicationModel({
    required super.data,
    required super.status,
    super.id,
  });

  factory SubmitLeaveApplicationModel.fromJson(Map<String, dynamic> json) {
    return SubmitLeaveApplicationModel(
      data: json['Data'] ?? "",
      status: json['Status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'Data': data, 'Status': status};
  }
}
