import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';

abstract class AcceptedFallbackRequestRemoteDataSource {
  Future<String> acceptedFallback(params);
}

class AcceptedFallbackRequestRemoteDataSourceImpl
    implements AcceptedFallbackRequestRemoteDataSource {
  final ApiService apiService;

  AcceptedFallbackRequestRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> acceptedFallback(props) async {
    try {
      final response = await apiService.post(
        ApiUrls.acceptedFallback,
        data: {
          "Remarks": props.remarks,
          "LeaveApplicationId": props.leaveApplicationId,
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
