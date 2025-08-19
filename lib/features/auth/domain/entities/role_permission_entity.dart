import '../../../../core/entities/entity.dart';

class RolePermissionEntity extends Entity {
  final int menuId;
  final int parentMenuId;
  final String menuName;
  final String controllerName;
  final int sort;
  final bool chkStatus;
  final String? mfsIcon;
  final String rolePermissionIds;
  final bool isNewMenu;

  RolePermissionEntity({
    super.id,
    required this.menuId,
    required this.parentMenuId,
    required this.menuName,
    required this.controllerName,
    required this.sort,
    required this.chkStatus,
    this.mfsIcon,
    required this.rolePermissionIds,
    required this.isNewMenu,
  });

  @override
  List<Object?> get props => [
    id,
    menuId,
    menuName,
    controllerName,
    sort,
    chkStatus,
    mfsIcon,
    rolePermissionIds,
    isNewMenu,
  ];

  RolePermissionEntity copyWith({
    String? id,
    int? menuId,
    int? parentMenuId,
    String? menuName,
    String? controllerName,
    int? sort,
    bool? chkStatus,
    String? mfsIcon,
    String? rolePermissionIds,
    bool? isNewMenu,
  }) {
    return RolePermissionEntity(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      parentMenuId: parentMenuId ?? this.parentMenuId,
      menuName: menuName ?? this.menuName,
      controllerName: controllerName ?? this.controllerName,
      sort: sort ?? this.sort,
      chkStatus: chkStatus ?? this.chkStatus,
      mfsIcon: mfsIcon ?? this.mfsIcon,
      rolePermissionIds: rolePermissionIds ?? this.rolePermissionIds,
      isNewMenu: isNewMenu ?? this.isNewMenu,
    );
  }
}
