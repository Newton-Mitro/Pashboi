import 'package:flutter_test/flutter_test.dart';
import 'package:pashboi/features/authenticated_pages/user/data/models/user_model.dart';
import 'package:pashboi/features/authenticated_pages/user/domain/entities/user_entity.dart';

void main() {
  group('UserModel', () {
    final mockJson = {
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
    };

    test('UserModel should extend UserEntity', () {
      final user = UserModel(
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
      );
      expect(user, isA<UserEntity>());
    });

    test('fromJson creates a valid UserModel', () {
      final user = UserModel.fromJson(mockJson);

      expect(user.userId, 1);
      expect(user.personId, 101);
      expect(user.loginEmail, 'user@example.com');
      expect(user.roleId, '5');
      expect(user.roleName, 'Admin');
      expect(user.userName, 'John Doe');
      expect(user.userPicture, 'https://example.com/avatar.png');
      expect(user.branchCode, 'BR001');
      expect(user.regMobile, '017XXXXXXXX');
      expect(user.address, '123 Street');
      expect(user.organizationCode, 'ORG001');
      expect(user.deviceId, 123456);
      expect(user.employeeCode, 'EMP123');
      expect(user.isNewMenu, true);
      expect(user.rolePermissions.length, 2);
      expect(user.rolePermissions.first.menuName, 'Dashboard');
      expect(user.rolePermissions.first.menuId, 1);
    });

    test('toJson returns correct map', () {
      final user = UserModel.fromJson(mockJson);
      final json = user.toJson();

      expect(json['userid'], 1);
      expect(json['personid'], 101);
      expect(json['loginemail'], 'user@example.com');
      expect(json['RoleId'], '5');
      expect(json['RoleName'], 'Admin');
      expect(json['UserName'], 'John Doe');
      expect(json['UserPicture'], 'https://example.com/avatar.png');
      expect(json['BranchCode'], 'BR001');
      expect(json['RegMobile'], '017XXXXXXXX');
      expect(json['Address'], '123 Street');
      expect(json['OrganizationCode'], 'ORG001');
      expect(json['DeviceId'], 123456);
      expect(json['EmployeeCode'], 'EMP123');
      expect(json['IsNewMenu'], true);
      expect(json['RolePermissionModelList'], isA<List>());
      expect(json['RolePermissionModelList'][0]['menuName'], 'Dashboard');
      expect(json['RolePermissionModelList'][1]['menuName'], 'Settings');
    });
  });
}
