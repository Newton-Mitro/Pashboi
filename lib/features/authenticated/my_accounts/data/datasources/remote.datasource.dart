import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/account_transaction_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/deposit_account_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';

abstract class DepositAccountRemoteDataSource {
  Future<List<DepositAccountModel>> getMyAccounts(GetMyAccountsProps props);
  Future<DepositAccountModel> getAccountDetails(GetAccountDetailsProps props);
  Future<List<AccountTransactionModel>> getAccountStatement(
    GetAccountStatementProps props,
  );
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
          "AccountNo": props.accountNumber,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final depositAccount = DepositAccountModel.fromJson(jsonResponse.first);

        return depositAccount;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AccountTransactionModel>> getAccountStatement(
    GetAccountStatementProps props,
  ) async {
    try {
      // Calculate dynamic dates
      final now = DateTime.now();
      final startDate = DateTime(now.year, now.month - 6, now.day);

      // Format dates (adjust format as per backend requirement)
      final formattedStartDate =
          "${startDate.year}/${startDate.month}/${startDate.day}";
      final formattedEndDate = "${now.month}/${now.year}/${now.day}";

      final response = await apiService.post(
        ApiUrls.getAccountStatement,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "AccountNo": props.accountNumber,
          "StartDate": formattedStartDate,
          "EndDate": formattedEndDate,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        return jsonResponse
            .map((json) => AccountTransactionModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
