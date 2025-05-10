import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pashboi/features/auth/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  @override
  ResultFuture<UserEntity> login(String email, String password) async {
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
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<UserEntity> getAuthUser() async {
    try {
      final user = await authLocalDataSource.getUser();

      return Right(user);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
