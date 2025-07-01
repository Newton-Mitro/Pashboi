import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/sureties/data/models/surety_model.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_given_sureties_usecase.dart';
import 'package:pashboi/features/authenticated/sureties/domain/usecases/fetch_loan_sureties_usecase.dart';

abstract class SuretyRemoteDataSource {
  Future<List<SuretyModel>> fetchLoanSureties(FetchLoanSuretiesProps props);
  Future<List<SuretyModel>> fetchGivenSureties(FetchGivenSuretiesProps props);
}

class SuretyRemoteDataSourceImpl implements SuretyRemoteDataSource {
  final ApiService apiService;

  SuretyRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<SuretyModel>> fetchGivenSureties(
    FetchGivenSuretiesProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getLoanSureties,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final sureties =
            jsonResponse.map((json) => SuretyModel.fromJson(json)).toList();

        return sureties;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SuretyModel>> fetchLoanSureties(
    FetchLoanSuretiesProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getLoanSureties,
        data: {
          "LoanId": props.loanNumber,
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final sureties =
            jsonResponse.map((json) => SuretyModel.fromJson(json)).toList();

        return sureties;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
