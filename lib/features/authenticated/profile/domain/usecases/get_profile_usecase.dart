import 'package:pashboi/core/requests/base_request_props.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';
import 'package:pashboi/features/authenticated/profile/domain/repositories/profile_repository.dart';

class GetProfileProps extends BaseRequestProps {
  const GetProfileProps({
    required super.email,
    required super.userId,
    required super.rolePermissionId,
    required super.personId,
    required super.employeeCode,
    required super.mobileNumber,
  });
}

class GetProfileUseCase extends UseCase<PersonEntity, GetProfileProps> {
  final ProfileRepository profileRepository;

  GetProfileUseCase({required this.profileRepository});

  @override
  ResultFuture<PersonEntity> call(GetProfileProps params) async {
    return await profileRepository.getProfile(params);
  }
}
