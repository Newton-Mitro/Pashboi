import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/my_loans/data/models/loan_account_model.dart';
import 'package:pashboi/features/authenticated/my_loans/data/models/loan_transaction_model.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_details_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_loan_statement_usecase.dart';
import 'package:pashboi/features/authenticated/my_loans/domain/usecases/fetch_my_loans_usecase.dart';

abstract class LoanRemoteDataSource {
  Future<List<LoanAccountModel>> fetchMyLoans(FetchMyLoansProps props);
  Future<LoanAccountModel> fetchLoanDetails(FetchLoanDetailsProps props);
  // Future<String> createInstantLoanAccount(LoanAccountEntity loanAccount);
  // Future<String> createProductLoanAccount(LoanAccountEntity loanAccount);
  Future<List<LoanTransactionModel>> fetchLoanStatement(
    FetchLoanStatementProps props,
  );
  // Future<void> getEligibleCollateralAccounts(int id);
  // Future<void> getEligibleLoanProducts(int id);
  // Future<void> getLoanAgainstProductInterest(int id);
}

class LoanRemoteDataSourceImpl implements LoanRemoteDataSource {
  final ApiService apiService;

  LoanRemoteDataSourceImpl({required this.apiService});

  @override
  Future<LoanAccountModel> fetchLoanDetails(FetchLoanDetailsProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getLoanDetails,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "LoanId": props.loanNumber,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final loanDetails = LoanAccountModel.fromJson(jsonResponse.first);

        return loanDetails;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LoanTransactionModel>> fetchLoanStatement(
    FetchLoanStatementProps props,
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
        ApiUrls.getLoanStatement,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "loanNo": props.loanNumber,
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
            .map((json) => LoanTransactionModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LoanAccountModel>> fetchMyLoans(FetchMyLoansProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getMyLoans,
        data: {
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
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final myLoans =
            jsonResponse.map((json) {
              return LoanAccountModel.fromJson(json);
            }).toList();

        return myLoans;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
