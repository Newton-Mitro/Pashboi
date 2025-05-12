import 'package:flutter_test/flutter_test.dart';
import 'package:pashboi/features/auth/data/models/role_permission_model.dart';
import 'package:pashboi/features/auth/domain/entities/role_permission_entity.dart';

void main() {
  group('RolePermissionModel', () {
    final mockJson = {
      'menuId': 1,
      'parentMenuId': 0,
      'menuName': 'Dashboard',
      'sort': 1,
      'chkStatus': true,
      'mfsIcon': 'icon.png',
      'rolePermissionIds': 'role123',
      'isNewMenu': true,
    };

    test('RolePermissionModel should extend RolePermissionEntity', () {
      final rolePermission = RolePermissionModel(
        menuId: 1,
        parentMenuId: 0,
        menuName: 'Dashboard',
        sort: 1,
        chkStatus: true,
        rolePermissionIds: 'abc',
        isNewMenu: false,
      );
      expect(rolePermission, isA<RolePermissionEntity>());
    });

    test('fromJson creates a valid RolePermissionModel', () {
      final rolePermission = RolePermissionModel.fromJson(mockJson);

      expect(rolePermission.menuId, 1);
      expect(rolePermission.parentMenuId, 0);
      expect(rolePermission.menuName, 'Dashboard');
      expect(rolePermission.sort, 1);
      expect(rolePermission.chkStatus, true);
      expect(rolePermission.mfsIcon, 'icon.png');
      expect(rolePermission.rolePermissionIds, 'role123');
      expect(rolePermission.isNewMenu, true);
    });

    test('toJson returns correct map', () {
      final rolePermission = RolePermissionModel.fromJson(mockJson);
      final json = rolePermission.toJson();

      expect(json['menuId'], 1);
      expect(json['parentMenuId'], 0);
      expect(json['menuName'], 'Dashboard');
      expect(json['sort'], 1);
      expect(json['chkStatus'], true);
      expect(json['mfsIcon'], 'icon.png');
      expect(json['rolePermissionIds'], 'role123');
      expect(json['isNewMenu'], true);
    });
  });
}
