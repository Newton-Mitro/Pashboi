import 'package:pashboi/features/auth/domain/entities/role_permission_entity.dart';

class RolePermissionModel extends RolePermissionEntity {
  RolePermissionModel({
    super.id,
    required super.menuId,
    required super.parentMenuId,
    required super.menuName,
    required super.controllerName,
    required super.sort,
    required super.chkStatus,
    super.mfsIcon,
    required super.rolePermissionIds,
    required super.isNewMenu,
  });

  factory RolePermissionModel.fromJson(Map<String, dynamic> json) {
    return RolePermissionModel(
      menuId: json['MenuId'] ?? 0,
      parentMenuId: json['parentMenuId'] ?? 0,
      menuName: json['MenuName'] ?? '',
      controllerName: json['ControllerName'] ?? '',
      sort: json['Sort'] ?? 0,
      chkStatus: json['ChkStatus'] ?? false,
      mfsIcon: json['MfsIcon'],
      rolePermissionIds: json['RolePermissionIds'] ?? '',
      isNewMenu: json['IsNewMenu'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'MenuId': menuId,
      'parentMenuId': parentMenuId,
      'MenuName': menuName,
      'ControllerName': controllerName,
      'Sort': sort,
      'ChkStatus': chkStatus,
      'MfsIcon': mfsIcon,
      'RolePermissionIds': rolePermissionIds,
      'IsNewMenu': isNewMenu,
    };
  }
}
