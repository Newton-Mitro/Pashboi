import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/submit_leave_application_usecase.dart';

abstract class SubmitLeaveApplicationRemoteDataSource {
  Future<String> submitLeaveApplication(SubmitLeaveApplicationProps props);
}

class SubmitLeaveApplicationRemoteDataSourceImpl
    implements SubmitLeaveApplicationRemoteDataSource {
  final ApiService apiService;

  SubmitLeaveApplicationRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> submitLeaveApplication(
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
          "LeaveTypeCode": props.leaveTypeCode,
          "FromDate": props.fromDate,
          "ToDate": props.toDate,
          "FormTime": props.formTime,
          "ToTime": props.toTime,
          "RejoiningDate": props.rejoiningDate,
          "FallbackEmployeeCode": props.fallbackEmployeeCode,
          "Remarks": props.remarks,
          "LeaveStageRemarks": props.leaveStageRemarks,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];

        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage != null && statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            return dataString;
          }
        }
        throw ServerException(message: "Server Error");
      } else {
        throw ServerException(message: "Server Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
