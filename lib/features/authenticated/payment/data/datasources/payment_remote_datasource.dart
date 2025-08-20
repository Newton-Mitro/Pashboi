import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/payment/data/models/service_model.dart';
import 'package:pashboi/features/authenticated/payment/domain/entities/service_entity.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/fetch_payment_services_usecase.dart';
import 'package:pashboi/features/authenticated/payment/domain/usecases/submit_payment_usecase.dart';

abstract class PaymentRemoteDataSource {
  Future<List<ServiceEntity>> fetchPaymentServices(
    FetchPaymentServicesProps props,
  );
  Future<String> submitPayment(SubmitPaymentProps props);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final ApiService apiService;

  PaymentRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<ServiceEntity>> fetchPaymentServices(
    FetchPaymentServicesProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getPaymentServices,
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
        final errorMessage = response.data?['Message'];
        final statusMessage = response.data?['Status'];
        if (dataString == null || dataString.isNotEmpty) {
          if (statusMessage != null && statusMessage == "failed") {
            throw ServerException(message: errorMessage);
          } else {
            final jsonResponse = JsonUtil.decodeModelList(dataString);

            final beneficiaries =
                jsonResponse
                    .map((json) => ServiceModel.fromJson(json) as ServiceEntity)
                    .toList();

            return beneficiaries;
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
  Future<String> submitPayment(SubmitPaymentProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.submitPayment,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "AccHolder": "T-0063599", //card
          "AccNo": "T-0063599", //card
          "AccTransfer": "T-0058497", //Receiver
          "AccType": "16",
          "AccountNo": "T-0063599", //card
          "AccountNumber": "T-0063599", //doesn't exist
          "Amount": 500,
          "CardNo": "0010102700635993",
          "SecretKey": "1458e7509aa5f47ecfb92536e7dd1dc7",
          "NameOnCard": "BAPPY BESRA",
          "Remarks": "3538",
          "OTPRegId": "{{OTPRegId}}",
          "OTPValue": "{{OTPValue}}",
          "PaymentServiceCode": "03",
          "NotifyPersonId": "20528",
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
