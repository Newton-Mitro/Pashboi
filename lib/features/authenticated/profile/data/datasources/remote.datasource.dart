import 'dart:io';

import 'package:pashboi/core/constants/api_urls.dart';
import 'package:pashboi/core/services/network/api_service.dart';
import 'package:pashboi/core/utils/json_util.dart';
import 'package:pashboi/features/authenticated/profile/data/models/person_model.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/get_profile_usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/update_profile_image_usecase.dart';

abstract class ProfileRemoteDataSource {
  Future<PersonModel> getProfile(GetProfileProps props);
  Future<String> updateProfileImage(UpdateProfileImageProps props);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiService apiService;

  ProfileRemoteDataSourceImpl({required this.apiService});

  @override
  Future<PersonModel> getProfile(GetProfileProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.getUserProfile,
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
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final dataString = response.data?['Data'];
        if (dataString == null) throw Exception('Invalid response format');

        final jsonResponse = JsonUtil.decodeModelList(dataString);

        final personModel = PersonModel.fromJson(jsonResponse.first);

        return personModel;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> updateProfileImage(UpdateProfileImageProps props) async {
    try {
      final response = await apiService.post(
        ApiUrls.changeProfileImage,
        data: {
          "UserName": props.email,
          "ImageName": props.imageData,
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
        if (dataString == null) throw Exception('Invalid response format');

        return dataString;
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
