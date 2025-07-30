import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/beneficiaries/data/models/beneficiary_model.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/add_beneficiary_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/fetch_beneficiaries_usecase.dart';
import 'package:pashboi/features/authenticated/beneficiaries/domain/usecases/remove_beneficiary_usecase.dart';

abstract class BeneficiaryRemoteDataSource {
  Future<List<BeneficiaryModel>> fetchBeneficiaries(
    FetchBeneficiariesProps props,
  );

  Future<String> addBeneficiary(AddBeneficiaryProps props);
  Future<String> removeBeneficiary(RemoveBeneficiaryProps props);
}

class BeneficiaryRemoteDataSourceImpl implements BeneficiaryRemoteDataSource {
  final ApiService apiService;

  BeneficiaryRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<BeneficiaryModel>> fetchBeneficiaries(
    FetchBeneficiariesProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getBeneficiaries,
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
                    .map((json) => BeneficiaryModel.fromJson(json))
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
  Future<String> addBeneficiary(AddBeneficiaryProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.addBeneficiary,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "AccountNo": props.beneficiaryAccountNumber,
          "AccountHolderName": props.beneficiaryName,
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
  Future<String> removeBeneficiary(RemoveBeneficiaryProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.removeBeneficiary,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "AccountNo": props.beneficiaryAccountNumber,
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
