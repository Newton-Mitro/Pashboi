import 'package:pashboi/features/auth/domain/entities/role_permission_entity.dart';

class RolePermissionModel extends RolePermissionEntity {
  RolePermissionModel({
    super.id,
    required super.menuId,
    required super.parentMenuId,
    required super.menuName,
    required super.sort,
    required super.chkStatus,
    super.mfsIcon,
    required super.rolePermissionIds,
    required super.isNewMenu,
  });

  factory RolePermissionModel.fromJson(Map<String, dynamic> json) {
    return RolePermissionModel(
      id: json['id']?.toString(),
      menuId: json['menuId'],
      parentMenuId: json['parentMenuId'],
      menuName: json['menuName'],
      sort: json['sort'],
      chkStatus: json['chkStatus'],
      mfsIcon: json['mfsIcon'],
      rolePermissionIds: json['rolePermissionIds'],
      isNewMenu: json['isNewMenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuId': menuId,
      'parentMenuId': parentMenuId,
      'menuName': menuName,
      'sort': sort,
      'chkStatus': chkStatus,
      'mfsIcon': mfsIcon,
      'rolePermissionIds': rolePermissionIds,
      'isNewMenu': isNewMenu,
    };
  }
}
