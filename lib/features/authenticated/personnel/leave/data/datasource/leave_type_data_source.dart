import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/leave_type_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_usecase.dart';

abstract class LeaveTypeRemoteDataSource {
  Future<List<LeaveTypeModel>> fetchLeaveType(LeaveTypeProps props);
}

class LeaveTypeRemoteDataSourceImpl implements LeaveTypeRemoteDataSource {
  final ApiService apiService;

  LeaveTypeRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<LeaveTypeModel>> fetchLeaveType(LeaveTypeProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getLeaveType,
        data: {
          "UserName": props.email,
          "MobileNo": props.mobileNumber,
          "MobileNumber": props.mobileNumber,
          "RolePermissionId": props.rolePermissionId,
          "ByUserId": props.userId,
          "UID": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
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
            final jsonResponse = JsonUtil.decodeModelList(dataString);

            final leaveTypes =
                jsonResponse
                    .map<LeaveTypeModel>(
                      (json) => LeaveTypeModel.fromJson(json),
                    )
                    .toList();
            return leaveTypes;
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
