import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/agm_counter/data/models/agm_counter_model.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/entities/agm_counter_entity.dart';
import 'package:pashboi/features/authenticated/agm_counter/domain/usecases/fetch_agm_counter_info_usecase.dart';

abstract class AGMCounterRemoteDataSource {
  Future<AGMCounterEntity> fetchAGMCounterInfo(FetchAGMCounterInfoProps props);
}

class AGMCounterRemoteDataSourceImpl implements AGMCounterRemoteDataSource {
  final ApiService apiService;

  AGMCounterRemoteDataSourceImpl({required this.apiService});

  @override
  Future<AGMCounterEntity> fetchAGMCounterInfo(
    FetchAGMCounterInfoProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getAgmCounterInfo,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermissionId": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "AccountNo": props.accountNo,
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
            final decoded = jsonDecode(dataString);

            if (decoded is List && decoded.isNotEmpty) {
              final firstItem = decoded.first;
              return AGMCounterModel.fromJson(firstItem);
            } else {
              throw ServerException(message: errorMessage);
            }
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
