import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/withdraw/domain/usecases/generate_withdrawl_qr_usecase.dart';

abstract class WithdrawlRemoteDataSource {
  Future<String> generateWithdrawlQr(GenerateWithdrawlQrProps props);
}

class WithdrawlRemoteDataSourceImpl implements WithdrawlRemoteDataSource {
  final ApiService apiService;

  WithdrawlRemoteDataSourceImpl({required this.apiService});

  @override
  Future<String> generateWithdrawlQr(GenerateWithdrawlQrProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.generateWithdrawalOTQR,
        data: {
          "Amount": props.amount,
          "OTPRegId": props.otpRegId,
          "OTPValue": props.otpValue,
          "CardNo": props.cardNumber,
          "NameOnCard": props.nameOnCard,
          "SecretKey": props.cardPin,
          "AccountNo": props.accountNumber,
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
