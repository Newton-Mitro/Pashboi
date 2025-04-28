import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

class AuthUserModel extends AuthUserEntity {
  const AuthUserModel({
    required super.accessToken,
    required super.refreshToken,
    required super.user,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      accessToken: json['access_token'] ?? "",
      refreshToken: json['refresh_token'] ?? "",
      user: UserModel.fromJson(json["user"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      "user": (user as UserModel).toJson(),
    };
  }
}
