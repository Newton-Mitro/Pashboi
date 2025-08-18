import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/search_employee_model.dart';

abstract class SearchEmployeeDataSource {
  Future<List<SearchEmployeeModel>> fetchEmployee(props);
}

class SearchEmployeeDataSourceImpl implements SearchEmployeeDataSource {
  final ApiService apiService;

  SearchEmployeeDataSourceImpl({required this.apiService});
  @override
  Future<List<SearchEmployeeModel>> fetchEmployee(props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getSearchEmployee,
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
          "SearchText": props.searchText,
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

            final searchEmployee =
                jsonResponse
                    .map<SearchEmployeeModel>(
                      (json) => SearchEmployeeModel.fromJson(json),
                    )
                    .toList();
            return searchEmployee;
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
