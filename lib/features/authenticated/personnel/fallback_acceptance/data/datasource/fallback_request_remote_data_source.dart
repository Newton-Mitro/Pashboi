import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/personnel/fallback_acceptance/data/model/fallback_request_model.dart';

abstract class FallbackRequestRemoteDataSource {
  Future<List<FallbackRequestModel>> fetchFallbackRequest(props);
}

class FallbackRequestRemoteDataSourceImpl
    implements FallbackRequestRemoteDataSource {
  final ApiService apiService;

  FallbackRequestRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<FallbackRequestModel>> fetchFallbackRequest(props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getFallbackRequest,
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
        if (dataString == null) throw Exception('Invalid response format');
        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final fallbackRequest =
            jsonResponse
                .map<FallbackRequestModel>(
                  (json) => FallbackRequestModel.fromJson(json),
                )
                .toList();
        return fallbackRequest;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
