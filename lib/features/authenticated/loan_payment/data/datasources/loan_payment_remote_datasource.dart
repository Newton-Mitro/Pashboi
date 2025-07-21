import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/loan_payment/data/models/loan_payment_model.dart';
import 'package:pashboi/features/authenticated/loan_payment/domain/usecases/fetch_loan_payment_usecase.dart';

abstract class LoanPaymentRemoteDataSource {
  Future<LoanPaymentModel> fetchLoanPayment(FetchLoanPaymentProps props);
}

class LoanPaymentRemoteDataSourceImpl implements LoanPaymentRemoteDataSource {
  final ApiService apiService;

  LoanPaymentRemoteDataSourceImpl({required this.apiService});

  @override
  Future<LoanPaymentModel> fetchLoanPayment(FetchLoanPaymentProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.fetchLoanRepayment,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "RolePermission": props.rolePermissionId,
          "ByUserId": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "LoanNumber": props.loanNumber,
          "Days": props.interestDays,
          "InterestRate": props.interestRate,
          "IssuedAmount": props.loanBalance,
          "IssuedDate": props.issuedDate,
          "LastPaidDate": props.lastPaidDate,
          "LoanBalance": props.loanBalance,
          "LoanRefund": props.loanRefundAmount,
          "ModuleCode": props.moduleCode,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final loanPayments = jsonDecode(dataString) as List;
        final Map<String, dynamic> loanPayment = loanPayments[0];

        loanPayment['LoanNumber'] = props.loanNumber;

        final loanPaymentModel = LoanPaymentModel.fromJson(loanPayment);

        return loanPaymentModel;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
