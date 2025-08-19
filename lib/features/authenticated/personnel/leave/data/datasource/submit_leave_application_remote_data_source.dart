import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/submit_leave_application_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/submit_leave_application_usecase.dart';

abstract class SubmitLeaveApplicationRemoteDataSource {
  Future<SubmitLeaveApplicationModel> submitLeaveApplication(
    SubmitLeaveApplicationProps props,
  );
}

class SubmitLeaveApplicationRemoteDataSourceImpl
    implements SubmitLeaveApplicationRemoteDataSource {
  final ApiService apiService;

  SubmitLeaveApplicationRemoteDataSourceImpl({required this.apiService});

  @override
  Future<SubmitLeaveApplicationModel> submitLeaveApplication(
    SubmitLeaveApplicationProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.submitLeaveApplication,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RequestFrom": "MobileApp",
          "LeaveApplicationId": props.leaveApplicationId,
          "LeaveTypeCode": props.leaveTypeCode,
          "FromDate": props.fromDate,
          "ToDate": props.toDate,
          "RejoiningDate": props.rejoiningDate,
          "FallbackEmployeeCode": props.fallbackEmployeeCode,
          "Remarks": props.remarks,
          "LeaveStageRemarks": props.leaveStageRemarks,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;

        if (data == null || data['Data'] == null) {
          throw Exception('Invalid response format');
        }

        return SubmitLeaveApplicationModel(
          data: data['Data'] ?? '',
          status: data['Status'] ?? '',
        );
      } else {
        throw Exception(
          'Submit leave failed with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
