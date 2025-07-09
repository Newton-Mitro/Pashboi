import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/openable_account_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/tenure_amount_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/tenure_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenure_amounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_account_tenures_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_openable_accounts_usecase.dart';

abstract class AccountUtilRemoteDataSource {
  Future<List<TenureAmountModel>> fetchAccountTenureAmounts(
    FetchAccountTenureAmountsProps props,
  );
  Future<List<OpenableAccountModel>> fetchOpenableAccounts(
    FetchOpenableAccountsProps props,
  );
  Future<List<TenureModel>> fetchAccountTenures(FetchAccountTenuresProps props);
}

class AccountUtilRemoteDataSourceImpl implements AccountUtilRemoteDataSource {
  final ApiService apiService;

  AccountUtilRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<TenureAmountModel>> fetchAccountTenureAmounts(
    FetchAccountTenureAmountsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getDurationAmounts,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "Duration": props.duration,
          "ProductCode": props.productCode,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');
        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final depositAccounts =
            jsonResponse.map((json) {
              return TenureAmountModel.fromJson(json);
            }).toList();

        return depositAccounts;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TenureModel>> fetchAccountTenures(
    FetchAccountTenuresProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getDurations,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "ProductCode": props.productCode,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');
        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final tenures =
            jsonResponse.map((json) {
              return TenureModel.fromJson(json);
            }).toList();

        return tenures;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<OpenableAccountModel>> fetchOpenableAccounts(
    FetchOpenableAccountsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getApplicableDepositAccountTypes,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "ProductType": -1,
          "ProductCode": "-1",
          "IsOnlineApplicable": true,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');
        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final openableAccounts =
            jsonResponse.map((json) {
              return OpenableAccountModel.fromJson(json);
            }).toList();

        return openableAccounts;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
