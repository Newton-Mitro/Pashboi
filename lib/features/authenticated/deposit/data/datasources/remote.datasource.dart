import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_from_bkash_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_later_usecase.dart';
import 'package:pashboi/features/authenticated/deposit/domain/usecases/submit_deposit_now_usecase.dart';

abstract class DepositRemoteDataSource {
  Future<String> submitDepositNow(SubmitDepositNowProps props);
  Future<String> submitDepositLater(SubmitDepositLaterProps props);
  Future<String> submitDepositFromBkash(SubmitDepositFromBkashProps props);
}

class DepositRemoteDataSourceImpl implements DepositRemoteDataSource {
  final ApiService apiService;

  DepositRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> submitDepositNow(SubmitDepositNowProps props) async {
    try {
      final jsonList =
          props.collectionLedgers?.map((ledger) => ledger.toJson()).toList();

      final response = await apiService.post(
        ApiUrls.submitDepositNow,
        data: {
          "AccountHolderName": props.accountHolderName,
          "AccountId": props.accountId,
          "AccountType": props.accountType,
          "CardNo": props.cardNumber,
          "DepositDate": props.depositDate,
          "FromAccountNo": props.accountNumber,
          "LedgerId": props.ledgerId,
          "Remarks": "",
          "RepeatMonths": 0,
          "SecretKey": props.cardPin,
          "ServiceCharge": 0.0,
          "TotalAmount": props.totalDepositAmount,
          "TotalDepositAmount": props.totalDepositAmount,
          "TransactionMethod": props.transactionMethod,
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "TransactionType": props.transactionType,
          "AccountNo": props.accountNumber,
          "TransactionModels": jsonList,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "MobileNo": props.mobileNumber,
          "MobileNumber": props.mobileNumber,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
          "RolePermissionId": props.rolePermissionId,
          "UID": props.userId,
          "UserName": props.email,
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
  Future<String> submitDepositLater(SubmitDepositLaterProps props) async {
    try {
      final jsonList =
          props.collectionLedgers?.map((ledger) => ledger.toJson()).toList();

      final response = await apiService.post(
        ApiUrls.submitDepositLater,
        data: {
          "AccountHolderName": props.accountHolderName,
          "AccountId": props.accountId,
          "AccountType": props.accountType,
          "CardNo": props.cardNumber,
          "DepositDate": props.depositDate,
          "FromAccountNo": props.accountNumber,
          "LedgerId": props.ledgerId,
          "Remarks": "",
          "RepeatMonths": 0,
          "SecretKey": props.cardPin,
          "ServiceCharge": 0.0,
          "TotalAmount": props.totalDepositAmount,
          "TotalDepositAmount": props.totalDepositAmount,
          "TransactionMethod": props.transactionMethod,
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "TransactionType": props.transactionType,
          "AccountNo": props.accountNumber,
          "TransactionModels": jsonList,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "MobileNo": props.mobileNumber,
          "MobileNumber": props.mobileNumber,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
          "RolePermissionId": props.rolePermissionId,
          "UID": props.userId,
          "UserName": props.email,
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
  Future<String> submitDepositFromBkash(
    SubmitDepositFromBkashProps props,
  ) async {
    try {
      final jsonList =
          props.collectionLedgers?.map((ledger) => ledger.toJson()).toList();

      final response = await apiService.post(
        ApiUrls.bkashCreatePayment,
        data: {
          "AccountHolderName": props.accountHolderName,
          "AccountId": props.accountId,
          "AccountType": props.accountType,
          "CardNo": props.cardNumber,
          "DepositDate": props.depositDate,
          "FromAccountNo": props.accountNumber,
          "LedgerId": props.ledgerId,
          "Remarks": "",
          "RepeatMonths": 0,
          "SecretKey": props.cardPin,
          "ServiceCharge": 0.0,
          "TotalAmount": props.totalDepositAmount,
          "TotalDepositAmount": props.totalDepositAmount,
          "TransactionMethod": props.transactionMethod,
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "TransactionType": props.transactionType,
          "AccountNo": props.accountNumber,
          "TransactionModels": jsonList,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "MobileNo": props.mobileNumber,
          "MobileNumber": props.mobileNumber,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
          "RolePermissionId": props.rolePermissionId,
          "UID": props.userId,
          "UserName": props.email,
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
