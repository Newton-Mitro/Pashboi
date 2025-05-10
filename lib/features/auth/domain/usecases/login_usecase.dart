import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  ResultFuture<UserEntity> call(LoginParams params) async {
    final loggedInUser = await authRepository.login(
      params.email,
      md5.convert(utf8.encode(params.password)).toString(),
    );

    return loggedInUser;
  }
}
