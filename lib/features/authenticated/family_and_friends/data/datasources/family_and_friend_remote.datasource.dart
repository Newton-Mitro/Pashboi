import 'dart:convert';
import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/models/family_and_friend_model.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/add_family_and_friend_usecase.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/get_family_and_friends_usecase.dart';

abstract class FamilyAndFriendRemoteDataSource {
  Future<List<FamilyAndFriendModel>> getFamilyAndFriends(
    GetFamilyAndFriendsProps props,
  );
  Future<String> addFamilyAndFriend(AddFamilyAndFriendProps params);
}

class FamilyAndFriendRemoteDataSourceImpl
    implements FamilyAndFriendRemoteDataSource {
  final ApiService apiService;

  FamilyAndFriendRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<FamilyAndFriendModel>> getFamilyAndFriends(
    GetFamilyAndFriendsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getFamilyAndRelatives,
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber,
          "IncludeSelf": props.includeSelf,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');
        final decoded = jsonDecode(dataString);

        if (decoded is List && decoded.isNotEmpty) {
          final mappedData =
              decoded
                  .map((item) => FamilyAndFriendModel.fromJson(item))
                  .toList();

          return mappedData;
        } else {
          throw Exception('Card list is empty or invalid');
        }
      } else {
        throw Exception(
          'Failed to fetch family and friends, with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> addFamilyAndFriend(AddFamilyAndFriendProps params) async {
    try {
      final response = await apiService.post(
        ApiUrls.addFamilyOrRelative,
        data: {
          "ChildPersonId": params.childPersonId,
          "RelationTypeCode": params.relationTypeCode,
          "UserName": params.email,
          "UID": params.userId,
          "ByUserId": params.userId,
          "RolePermissionId": params.rolePermissionId,
          "PersonId": params.personId,
          "EmployeeCode": params.employeeCode,
          "MobileNumber": params.mobileNumber,
          "MobileNo": params.mobileNumber,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        return dataString;
      } else {
        throw Exception(
          'Failed to add Family or Friend, with status ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
