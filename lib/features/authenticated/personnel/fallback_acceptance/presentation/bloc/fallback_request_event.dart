part of 'fallback_request_bloc.dart';

sealed class FallbackRequestEvent extends Equatable {
  const FallbackRequestEvent();

  @override
  List<Object> get props => [];
}

final class FetchFallbackRequests extends FallbackRequestEvent {
  final String email;
  final String userId;
  final String rolePermissionId;
  final String personId;
  final String employeeCode;
  final String mobileNumber;

  const FetchFallbackRequests({
    required this.email,
    required this.userId,
    required this.rolePermissionId,
    required this.personId,
    required this.employeeCode,
    required this.mobileNumber,
  });

  @override
  List<Object> get props => [
    email,
    userId,
    rolePermissionId,
    personId,
    employeeCode,
    mobileNumber,
  ];
}
