import 'package:flutter_test/flutter_test.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';
import 'package:pashboi/features/authenticated/user/data/models/user_model.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';

void main() {
  group('AuthUserModel', () {
    final mockJson = {
      'access_token': 'mockAccessToken',
      'refresh_token': 'mockRefreshToken',
      'user': {
        'userid': 1,
        'personid': 101,
        'loginemail': 'user@example.com',
        'RoleId': '5',
        'RoleName': 'Admin',
        'UserName': 'John Doe',
        'UserPicture': 'https://example.com/avatar.png',
        'BranchCode': 'BR001',
        'RegMobile': '017XXXXXXXX',
        'Address': '123 Street',
        'OrganizationCode': 'ORG001',
        'DeviceId': 123456,
        'EmployeeCode': 'EMP123',
        'IsNewMenu': true,
        'RolePermissionModelList': [
          {
            'menuId': 1,
            'parentMenuId': 0,
            'menuName': 'Dashboard',
            'sort': 1,
            'chkStatus': true,
            'mfsIcon': 'icon.png',
            'rolePermissionIds': 'role123',
            'isNewMenu': true,
          },
          {
            'menuId': 2,
            'parentMenuId': 1,
            'menuName': 'Settings',
            'sort': 2,
            'chkStatus': false,
            'mfsIcon': 'settings.png',
            'rolePermissionIds': 'role124',
            'isNewMenu': false,
          },
        ],
      },
    };

    test('AuthUserModel should extend AuthUserEntity', () {
      final authUser = AuthUserModel(
        accessToken: 'mockAccessToken',
        refreshToken: 'mockRefreshToken',
        user: UserModel(
          userId: 1,
          personId: 2,
          loginEmail: 'a@b.com',
          roleId: '3',
          roleName: 'Admin',
          userName: 'John',
          branchCode: 'B1',
          regMobile: '0123456789',
          address: 'Some Address',
          organizationCode: 'ORG',
          deviceId: 123,
          employeeCode: 'EMP001',
          isNewMenu: false,
          rolePermissions: [],
        ),
      );
      expect(authUser, isA<AuthUserEntity>());
    });

    test('fromJson creates a valid AuthUserModel', () {
      final authUser = AuthUserModel.fromJson(mockJson);

      expect(authUser.accessToken, 'mockAccessToken');
      expect(authUser.refreshToken, 'mockRefreshToken');
      expect(authUser.user.userId, 1);
      expect(authUser.user.personId, 101);
      expect(authUser.user.loginEmail, 'user@example.com');
      expect(authUser.user.roleId, '5');
      expect(authUser.user.roleName, 'Admin');
      expect(authUser.user.userName, 'John Doe');
      expect(authUser.user.userPicture, 'https://example.com/avatar.png');
      expect(authUser.user.branchCode, 'BR001');
      expect(authUser.user.regMobile, '017XXXXXXXX');
      expect(authUser.user.address, '123 Street');
      expect(authUser.user.organizationCode, 'ORG001');
      expect(authUser.user.deviceId, 123456);
      expect(authUser.user.employeeCode, 'EMP123');
      expect(authUser.user.isNewMenu, true);
      expect(authUser.user.rolePermissions.length, 2);
      expect(authUser.user.rolePermissions.first.menuName, 'Dashboard');
      expect(authUser.user.rolePermissions.first.menuId, 1);
    });

    test('toJson returns correct map', () {
      final user = AuthUserModel.fromJson(mockJson);
      final json = user.toJson();

      final userJson = json['user'] as Map<String, dynamic>;

      expect(json['access_token'], 'mockAccessToken');
      expect(json['refresh_token'], 'mockRefreshToken');
      expect(json['user'], isA<Map<String, dynamic>>());
      expect(userJson['userid'], 1);
      expect(userJson['personid'], 101);
      expect(userJson['loginemail'], 'user@example.com');
      expect(userJson['RoleId'], '5');
      expect(userJson['RoleName'], 'Admin');
      expect(userJson['UserName'], 'John Doe');
      expect(userJson['UserPicture'], 'https://example.com/avatar.png');
      expect(userJson['BranchCode'], 'BR001');
      expect(userJson['RegMobile'], '017XXXXXXXX');
      expect(userJson['Address'], '123 Street');
      expect(userJson['OrganizationCode'], 'ORG001');
      expect(userJson['DeviceId'], 123456);
      expect(userJson['EmployeeCode'], 'EMP123');
      expect(userJson['IsNewMenu'], true);
      expect(userJson['RolePermissionModelList'], isA<List>());
      expect(userJson['RolePermissionModelList'][0]['menuName'], 'Dashboard');
      expect(userJson['RolePermissionModelList'][1]['menuName'], 'Settings');
    });
  });
}
