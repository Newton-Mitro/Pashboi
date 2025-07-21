import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/repositories/profile_repository.dart';

class ChangePasswordProps extends BaseRequestProps {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordProps({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class ChangePasswordUseCase extends UseCase<String, ChangePasswordProps> {
  final ProfileRepository profileRepository;

  ChangePasswordUseCase({required this.profileRepository});

  @override
  ResultFuture<String> call(ChangePasswordProps props) async {
    return profileRepository.changePassword(props);
  }
}
