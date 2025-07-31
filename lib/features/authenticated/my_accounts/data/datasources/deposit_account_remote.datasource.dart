import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/account_transaction_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/data/models/deposit_account_model.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/add_operating_account_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_dependents_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/fetch_operating_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_account_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/get_my_accounts_usecase.dart';
import 'package:pashboi/features/authenticated/my_accounts/domain/usecases/open_deposit_account_usecase.dart';

abstract class DepositAccountRemoteDataSource {
  Future<List<DepositAccountModel>> getMyAccounts(GetMyAccountsProps props);
  Future<DepositAccountModel> getAccountDetails(GetAccountDetailsProps props);
  Future<List<DepositAccountModel>> fetchDependents(FetchDependentsProps props);
  Future<List<DepositAccountModel>> fetchOperatingAccounts(
    FetchOperatingAccountsProps props,
  );
  Future<String> addOperatingAccount(AddOperatingAccountProps props);
  Future<List<AccountTransactionModel>> getAccountStatement(
    GetAccountStatementProps props,
  );
  Future<String> openDepositAccount(OpenDepositAccountParams props);
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
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];
        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage != null && statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            final jsonResponse = JsonUtil.decodeModelList(dataString);

            final depositAccounts =
                jsonResponse.map((json) {
                  return DepositAccountModel.fromJson(json);
                }).toList();

            return depositAccounts;
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
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];
        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage != null && statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            final jsonResponse = JsonUtil.decodeModelList(dataString);

            final depositAccount = DepositAccountModel.fromJson(
              jsonResponse.first,
            );

            return depositAccount;
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

  @override
  Future<List<AccountTransactionModel>> getAccountStatement(
    GetAccountStatementProps props,
  ) async {
    try {
      // Calculate dynamic dates
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
          "StartDate": props.fromDate,
          "EndDate": props.toDate,
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

            return jsonResponse
                .map((json) => AccountTransactionModel.fromJson(json))
                .toList();
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

  @override
  Future<String> addOperatingAccount(AddOperatingAccountProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.addDependent,
        data: {
          "AccountOperators": [
            {
              "AccountHolderId": props.accountHolderId,
              "AccountOperatorId": props.operatorId,
              "AccountHolderInfoId": props.accountHolderInfoId,
            },
          ],
          "UserName": props.email,
          "Remarks": "Add Dependent",
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
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

  @override
  Future<List<DepositAccountModel>> fetchDependents(
    FetchDependentsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getDependentAccounts,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "DependentPersonId": props.dependentPersonId,
          "MobileNo": props.mobileNumber,
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

            return jsonResponse
                .map((json) => DepositAccountModel.fromJson(json))
                .toList();
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

  @override
  Future<List<DepositAccountModel>> fetchOperatingAccounts(
    FetchOperatingAccountsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getDependentAccounts,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "DependentPersonId": props.dependentPersonId,
          "MobileNo": props.mobileNumber,
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

            return jsonResponse
                .map((json) => DepositAccountModel.fromJson(json))
                .toList();
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

  @override
  Future<String> openDepositAccount(OpenDepositAccountParams props) async {
    try {
      final response = await apiService.post(
        ApiUrls.createDepositAccount,
        data: {
          "AccountHolders": [
            {
              "AccountHolderId": 29960,
              "IsOrganization": false,
              "MembershipNumber": "",
              "SavingsACNumber": "T-0037417",
            },
          ],
          "Nominees": [
            {"NomineePercentage": 100, "PersonId": 52155},
          ],
          "AccountOperators": [
            {"AccountHolderId": 37425, "AccountOperatorId": 37425},
          ],
          "Introducers": [],
          "DMSProductCode": "20",
          "ApplicationNo": "",
          "BranchCode": "00",
          "AccountFor": 1,
          "AccountName": "RIPON  BAROI",
          "InterestRate": 8.5,
          "Duration": 60,
          "InstallmentAmount": 500,
          "TxnAccountNumber": "T-0051979",
          "InterestPostingAccount": "",
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
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
