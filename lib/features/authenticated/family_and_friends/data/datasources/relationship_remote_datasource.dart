import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/errors/exceptions.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/family_and_friends/data/models/realtionship_model.dart';
import 'package:pashboi/features/authenticated/family_and_friends/domain/usecases/fetch_relationships_usecase.dart';

abstract class RelationshipRemoteDataSource {
  Future<List<RelationshipModel>> fetchRelationships(
    FetchRelationshipsProps props,
  );
}

class RelationshipRemoteDataSourceImpl implements RelationshipRemoteDataSource {
  final ApiService apiService;

  RelationshipRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<RelationshipModel>> fetchRelationships(
    FetchRelationshipsProps props,
  ) async {
    try {
      final response = await apiService.post(
        ApiUrls.getRelationshipTypes, // ✅ Use actual relationship endpoint
        data: {
          "UserName": props.email,
          "UID": props.userId,
          "ByUserId": props.userId,
          "RolePermissionId": props.rolePermissionId,
          "PersonId": props.personId,
          "EmployeeCode": props.employeeCode,
          "MobileNumber": props.mobileNumber,
          "MobileNo": props.mobileNumber, // if API needs both
          "RelationTypeCode": "",
          "Gender": props.gender,
          "RequestFrom": "MobileApp",
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        final errorMessage = response.data?['Message'];
        if (dataString == null || dataString.isEmpty) {
          if (errorMessage != null) {
            throw ServerException(message: errorMessage);
          } else {
            throw ServerException(message: 'Invalid response format');
          }
        }

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final mappedData =
            jsonResponse
                .map<RelationshipModel>(
                  (item) => RelationshipModel.fromJson(item),
                )
                .toList();

        return mappedData;
      } else {
        throw Exception(
          'Failed to fetch relationships. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching relationships: ${e.toString()}');
    }
  }
}
