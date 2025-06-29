import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/deposit_account_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/entities/deposit_account_entity.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

abstract class DepositAccountRemoteDataSource {
  Future<List<DepositAccountEntity>> getMyAccounts(GetMyAccountsProps props);
  Future<DepositAccountEntity> getAccountDetails(GetAccountDetailsProps props);
}

class DepositAccountRemoteDataSourceImpl
    implements DepositAccountRemoteDataSource {
  final ApiService apiService;

  DepositAccountRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<DepositAccountModel>> getMyAccounts(
    GetMyAccountsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getMyAccounts,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "AccHolderPersonId": props.accountHolderPersonId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final depositAccounts =
            jsonResponse.map((json) {
              return DepositAccountModel.fromJson(json);
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
  Future<DepositAccountModel> getAccountDetails(
    GetAccountDetailsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getAccountDetails,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "AccHolderPersonId": props.accountHolderPersonId,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModel(dataString);

        final depositAccount = DepositAccountModel.fromJson(jsonResponse);

        return depositAccount;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
