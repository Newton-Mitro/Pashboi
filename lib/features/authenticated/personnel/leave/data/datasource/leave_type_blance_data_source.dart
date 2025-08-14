import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/get_leave_type_blance_dto.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/leave_info_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/data/model/leave_summery_model.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/usecase/leave_type_blance_usecase.dart';

abstract class LeaveTypeBalanceDataSource {
  Future<LeaveTypeBalanceDto> fetchLeaveTypeBalance(
    LeaveTypeBalanceProps props,
  );
}

class LeaveTypeBalanceDataSourceImpl implements LeaveTypeBalanceDataSource {
  final ApiService apiService;

  LeaveTypeBalanceDataSourceImpl({required this.apiService});

  @override
  Future<LeaveTypeBalanceDto> fetchLeaveTypeBalance(
    LeaveTypeBalanceProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.leaveTypeBalance,
        data: {
          "UserName": props.email,
          "MobileNo": props.mobileNumber,
          "MobileNumber": props.mobileNumber,
          "RolePermissionId": props.rolePermissionId,
          "ByUserId": props.userId,
          "UID": props.userId,
          "EmployeeCode": props.employeeCode,
          "PersonId": props.personId,
          "RequestFrom": "MobileApp",
          "leaveTypeCode": props.leaveTypeCode,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data?['Data'];

        if (data == null) throw Exception('Invalid response format');

        final newData = jsonDecode(data);

        final leaveInfo = LeaveInfoModel.fromJson(newData['LeaveInfo']);
        final leaveSummaryList =
            (newData['LeaveSummary'] as List)
                .map((e) => LeaveSummeryModel.fromJson(e))
                .toList();

        return LeaveTypeBalanceDto(
          leaveInfo: leaveInfo,
          leaveSummary: leaveSummaryList,
        );
      } else {
        throw Exception('Request failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
