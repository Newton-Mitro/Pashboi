import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';
import 'package:pashboi/features/authenticated_home/notifier/notifiers.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final LocalStorage localStorage;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
    required this.localStorage,
  });

  @override
  ResultFuture<UserEntity> login(String? email, String? password) async {
    try {
      final result = await authRemoteDataSource.login(email, password);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final result = await authRemoteDataSource.register(
        name,
        email,
        password,
        confirmPassword,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultVoid logout() async {
    try {
      final result = await authRemoteDataSource.logout();
      await _clearToken();
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  ResultVoid _clearToken() async {
    try {
      await localStorage.remove(StorageKey.keyAccessToken);
      await localStorage.remove(StorageKey.keyAuthUser);
      authUserNotifier.value = null;
      accessTokenNotifier.value = null;
      selectedPageNotifier.value = 0;
      return Right(null);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> getAuthUser() async {
    try {
      final authToken = await localStorage.getString(StorageKey.keyAccessToken);

      final stringUser = await localStorage.getString(StorageKey.keyAuthUser);

      if (stringUser != null && authToken != null) {
        final user = UserModel.fromJson(jsonDecode(stringUser));
        accessTokenNotifier.value = authToken;
        authUserNotifier.value = user;

        final UserEntity authUserEntity = UserEntity(
          id: user.id,
          userId: user.userId,
          personId: user.personId,
          loginEmail: user.loginEmail,
          roleId: user.roleId,
          roleName: user.roleName,
          userName: user.userName,
          userPicture: user.userPicture,
          branchCode: user.branchCode,
          regMobile: user.regMobile,
          address: user.address,
          organizationCode: user.organizationCode,
          deviceId: user.deviceId,
          employeeCode: user.employeeCode,
          isNewMenu: user.isNewMenu,
          rolePermissions: user.rolePermissions,
        );

        return Right(authUserEntity);
      }
      return Left(FailureMapper.fromException(CacheFailure()));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
