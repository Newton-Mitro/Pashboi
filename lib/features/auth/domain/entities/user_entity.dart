import 'package:pashboi/core/entities/entity.dart';
import 'package:pashboi/features/auth/domain/entities/role_permission_entity.dart';

class UserEntity extends Entity {
  final int userId;
  final int personId;
  final String loginEmail;
  final String roleId;
  final String roleName;
  final String userName;
  final String? userPicture;
  final String branchCode;
  final String regMobile;
  final String address;
  final String organizationCode;
  final int deviceId;
  final String employeeCode;
  final bool isNewMenu;
  final List<RolePermissionEntity> rolePermissions;

  UserEntity({
    super.id,
    required this.userId,
    required this.personId,
    required this.loginEmail,
    required this.roleId,
    required this.roleName,
    required this.userName,
    this.userPicture,
    required this.branchCode,
    required this.regMobile,
    required this.address,
    required this.organizationCode,
    required this.deviceId,
    required this.employeeCode,
    required this.isNewMenu,
    required this.rolePermissions,
  });

  @override
  List<Object?> get props => [id, userId, loginEmail];

  UserEntity copyWith({
    String? id,
    int? userId,
    int? personId,
    String? loginEmail,
    String? roleId,
    String? roleName,
    String? userName,
    String? userPicture,
    String? branchCode,
    String? regMobile,
    String? address,
    String? organizationCode,
    int? deviceId,
    String? employeeCode,
    bool? isNewMenu,
    List<RolePermissionEntity>? rolePermissions,
  }) {
    return UserEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      personId: personId ?? this.personId,
      loginEmail: loginEmail ?? this.loginEmail,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      userName: userName ?? this.userName,
      userPicture: userPicture ?? this.userPicture,
      branchCode: branchCode ?? this.branchCode,
      regMobile: regMobile ?? this.regMobile,
      address: address ?? this.address,
      organizationCode: organizationCode ?? this.organizationCode,
      deviceId: deviceId ?? this.deviceId,
      employeeCode: employeeCode ?? this.employeeCode,
      isNewMenu: isNewMenu ?? this.isNewMenu,
      rolePermissions: rolePermissions ?? this.rolePermissions,
    );
  }
}
