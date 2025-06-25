import 'package:equatable/equatable.dart';

abstract class BaseRequestProps extends Equatable {
  final String email;
  final int userId;
  final String rolePermissionId;
  final int personId;
  final String employeeCode;
  final String mobileNumber;
  final String requestFrom;

  const BaseRequestProps({
    required this.email,
    required this.userId,
    required this.rolePermissionId,
    required this.personId,
    required this.employeeCode,
    required this.mobileNumber,
    this.requestFrom = 'MOBILE',
  });

  @override
  List<Object?> get props => [
    email,
    userId,
    rolePermissionId,
    personId,
    employeeCode,
    mobileNumber,
    requestFrom,
  ];
}
