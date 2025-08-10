import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/transfer/domain/usecases/submit_fund_transfer_usecase.dart';

abstract class TransferRemoteDataSource {
  Future<String> submitFundTransfer(SubmitFundTransferProps props);
}

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final ApiService apiService;

  TransferRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> submitFundTransfer(SubmitFundTransferProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.submitFundTransfer,
        data: {
          "AccHolder": props.accountNumber,
          "AccountNo": props.accountNumber,
          "AccTransfer": props.toAccountNumber,
          "AccType": props.accountType,
          "Amount": props.amount,
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "CardNo": props.cardNumber,
          "NameOnCard": props.nameOnCard,
          "SecretKey": props.cardPin,
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
