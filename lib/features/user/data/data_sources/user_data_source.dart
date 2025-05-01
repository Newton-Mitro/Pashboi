import 'package:pashboi/features/user/data/models/user_model.dart';

abstract class UsersDataSource {
  Future<List<UserModel>> fetchProfile(
    int userId,
    int startRecord,
    int pageSize,
  );
}
