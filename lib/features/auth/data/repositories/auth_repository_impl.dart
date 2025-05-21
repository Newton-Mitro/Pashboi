import 'package:dartz/dartz.dart';
import 'package:pashboi/core/services/network/network_info.dart';
import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/utils/failure_mapper.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:pashboi/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';
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
  ResultFuture<AuthUserEntity> login(String email, String password) async {
    try {
      final result = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.setAuthUser(result);
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> register(
    String email,
    String password,
    String confirmPassword,
    String requestFrom,
  ) async {
    try {
      final result = await authRemoteDataSource.register(
        email,
        password,
        confirmPassword,
        requestFrom,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<void> logout() async {
    try {
      await authLocalDataSource.clearAuthUser();
      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<AuthUserEntity> getAuthUser() async {
    try {
      final user = await authLocalDataSource.getAuthUser();

      return Right(user);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> verifyMobileNumber(
    String mobileNumber,
    bool isRegistered,
    String requestFrom,
  ) async {
    try {
      final result = await authRemoteDataSource.verifyMobileNumber(
        mobileNumber,
        isRegistered,
        requestFrom,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<String> verifyOtp(
    String otpRegId,
    String otpValue,
    String mobileNumber,
    String requestFrom,
  ) async {
    try {
      final result = await authRemoteDataSource.verifyOtp(
        otpRegId,
        otpValue,
        mobileNumber,
        requestFrom,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
