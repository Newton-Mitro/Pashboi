import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/get_profile_usecase.dart';
import 'package:pashboi/features/authenticated/profile/domain/usecases/update_profile_image_usecase.dart';

abstract class ProfileRepository {
  ResultFuture<PersonEntity> getProfile(GetProfileProps props);
  ResultFuture<String> updateProfileImage(UpdateProfileImageProps props);
}
