import 'package:pashboi/features/authenticated/profile/domain/entities/person_entity.dart';

abstract class ProfileRepository {
  Future<PersonEntity> getProfile();
  // Future<void> updateProfile(String name, String email, String phone);
  Future<void> updatePassword(String password, String newPassword);
  Future<void> updateImage(String image);
}
