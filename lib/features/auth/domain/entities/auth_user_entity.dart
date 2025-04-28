import 'package:equatable/equatable.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';

class AuthUserEntity extends Equatable {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  const AuthUserEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  AuthUserEntity copyWith({
    String? accessToken,
    String? refreshToken,
    UserEntity? user,
  }) {
    return AuthUserEntity(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, user];
}
