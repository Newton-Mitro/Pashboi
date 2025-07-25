import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/data/models/role_permission_model.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    required super.userId,
    required super.personId,
    required super.loginEmail,
    required super.roleId,
    required super.roleName,
    required super.userName,
    super.userPicture,
    required super.branchCode,
    required super.regMobile,
    required super.address,
    required super.organizationCode,
    required super.deviceId,
    required super.employeeCode,
    required super.isNewMenu,
    super.accessToken,
    required super.rolePermissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userId: json['userid'] ?? 0,
      personId: json['personid'] ?? 0,
      loginEmail: json['loginemail'] ?? '',
      roleId: json['RoleId'] ?? '',
      roleName: json['RoleName'] ?? '',
      userName: json['UserName'] ?? '',
      userPicture: json['UserPicture'],
      branchCode: json['BranchCode'] ?? '',
      regMobile: json['RegMobile'] ?? '',
      address: json['Address'] ?? '',
      organizationCode: json['OrganizationCode'] ?? '',
      deviceId: json['DeviceId'] ?? 0,
      employeeCode: json['EmployeeCode'] ?? '',
      isNewMenu: json['IsNewMenu'] ?? false,
      accessToken: json['accessToken'],
      rolePermissions:
          (json['RolePermissionModelList'] as List<dynamic>)
              .map((e) => RolePermissionModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userId,
      'personid': personId,
      'loginemail': loginEmail,
      'RoleId': roleId,
      'RoleName': roleName,
      'UserName': userName,
      'UserPicture': userPicture,
      'BranchCode': branchCode,
      'RegMobile': regMobile,
      'Address': address,
      'OrganizationCode': organizationCode,
      'DeviceId': deviceId,
      'EmployeeCode': employeeCode,
      'IsNewMenu': isNewMenu,
      'accessToken': accessToken,
      'RolePermissionModelList':
          rolePermissions
              .map((e) => (e as RolePermissionModel).toJson())
              .toList(),
    };
  }
}
