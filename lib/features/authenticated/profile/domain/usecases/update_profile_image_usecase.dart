import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/repositories/profile_repository.dart';

class UpdateProfileImageProps extends BaseRequestProps {
  final String imageData;

  const UpdateProfileImageProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
    required this.imageData,
  });
}

class UpdateProfileImageUseCase
    extends UseCase<String, UpdateProfileImageProps> {
  final ProfileRepository profileRepository;

  UpdateProfileImageUseCase({required this.profileRepository});

  @override
  ResultFuture<String> call(UpdateProfileImageProps params) async {
    return await profileRepository.updateProfileImage(params);
  }
}
