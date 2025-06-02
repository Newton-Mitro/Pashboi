import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';
import 'package:pashboi/features/authenticated_pages/user/data/models/user_model.dart';
import 'package:pashboi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRemoteDataSource mockRemote;
  late MockAuthLocalDataSource mockLocal;
  late MockNetworkInfo mockNetwork;
  late AuthRepository repository;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tName = 'Test User';
  const tConfirmPassword = 'password123';
  const tToken = 'mock_token';

  final tUserModel = AuthUserModel(
    accessToken: 'mockAccessToken',
    refreshToken: 'mockRefreshToken',
    user: UserModel(
      id: 'uuid-123',
      userId: 1,
      personId: 1,
      loginEmail: tEmail,
      roleId: 'admin',
      roleName: 'Administrator',
      userName: tName,
      userPicture: '',
      branchCode: 'BR001',
      regMobile: '01700000000',
      address: '123 Street',
      organizationCode: 'ORG001',
      deviceId: 12345,
      employeeCode: 'EMP001',
      isNewMenu: false,
      accessToken: tToken,
      rolePermissions: [],
    ),
  );

  setUp(() {
    mockRemote = MockAuthRemoteDataSource();
    mockLocal = MockAuthLocalDataSource();
    mockNetwork = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      authRemoteDataSource: mockRemote,
      authLocalDataSource: mockLocal,
      networkInfo: mockNetwork,
    );
  });

  group('login', () {
    test(
      'should return Right(UserEntity) on success and cache user locally',
      () async {
        when(
          () => mockRemote.login(tEmail, tPassword),
        ).thenAnswer((_) async => tUserModel);
        when(
          () => mockLocal.setAuthUser(tUserModel),
        ).thenAnswer((_) async => {});

        final result = await repository.login(tEmail, tPassword);

        expect(result, Right(tUserModel));
        verify(() => mockRemote.login(tEmail, tPassword)).called(1);
        verify(() => mockLocal.setAuthUser(tUserModel)).called(1);
      },
    );

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.login(tEmail, tPassword),
      ).thenThrow(Exception('Login failed'));

      final result = await repository.login(tEmail, tPassword);

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('register', () {
    test('should return Right(UserEntity) on success', () async {
      when(
        () => mockRemote.register(tEmail, tPassword, tConfirmPassword),
      ).thenAnswer((_) async => 'User registered successfully');

      final result = await repository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
      );

      expect(result, Right('User registered successfully'));
      verify(
        () => mockRemote.register(tEmail, tPassword, tConfirmPassword),
      ).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.register(tEmail, tPassword, tConfirmPassword),
      ).thenThrow(Exception('Registration failed'));

      final result = await repository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
      );

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('logout', () {
    test('should return Right(void) on success', () async {
      when(() => mockLocal.clearAuthUser()).thenAnswer((_) async => {});

      final result = await repository.logout();

      expect(result.isRight(), true);
      verify(() => mockLocal.clearAuthUser()).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockLocal.clearAuthUser(),
      ).thenThrow(Exception('Logout failed'));

      final result = await repository.logout();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('getAuthUser', () {
    test('should return Right(UserEntity) from local storage', () async {
      when(() => mockLocal.getAuthUser()).thenAnswer((_) async => tUserModel);

      final result = await repository.getAuthUser();

      expect(result, Right(tUserModel));
      verify(() => mockLocal.getAuthUser()).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(() => mockLocal.getAuthUser()).thenThrow(Exception('Cache error'));

      final result = await repository.getAuthUser();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('verifyMobileNumber', () {
    const mobileNumber = '01700000000';
    const verificationResponse = 'OTP sent';
    const isRegistered = true;

    test(
      'should return Right(String) and cache mobile number on success',
      () async {
        when(
          () => mockRemote.verifyMobileNumber(mobileNumber, isRegistered),
        ).thenAnswer((_) async => verificationResponse);
        when(
          () => mockLocal.setRegisteredMobile(mobileNumber),
        ).thenAnswer((_) async => {});

        final result = await repository.verifyMobileNumber(
          mobileNumber,
          isRegistered,
        );

        expect(result, Right(verificationResponse));
        verify(
          () => mockRemote.verifyMobileNumber(mobileNumber, isRegistered),
        ).called(1);
        verify(() => mockLocal.setRegisteredMobile(mobileNumber)).called(1);
      },
    );

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.verifyMobileNumber(mobileNumber, isRegistered),
      ).thenThrow(Exception('Network error'));

      final result = await repository.verifyMobileNumber(
        mobileNumber,
        isRegistered,
      );

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('verifyOtp', () {
    const otpRegId = 'otp123';
    const otpValue = '123456';
    const mobileNumber = '01700000000';
    const verificationResult = 'Verified';

    test('should return Right(String) on success', () async {
      when(
        () => mockRemote.verifyOtp(otpRegId, otpValue, mobileNumber),
      ).thenAnswer((_) async => verificationResult);

      final result = await repository.verifyOtp(
        otpRegId,
        otpValue,
        mobileNumber,
      );

      expect(result, Right(verificationResult));
      verify(
        () => mockRemote.verifyOtp(otpRegId, otpValue, mobileNumber),
      ).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.verifyOtp(otpRegId, otpValue, mobileNumber),
      ).thenThrow(Exception('OTP failed'));

      final result = await repository.verifyOtp(
        otpRegId,
        otpValue,
        mobileNumber,
      );

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('getRegisteredMobile', () {
    const registeredMobile = '01700000000';

    test('should return Right(String) from local storage', () async {
      when(
        () => mockLocal.getRegisteredMobile(),
      ).thenAnswer((_) async => registeredMobile);

      final result = await repository.getRegisteredMobile();

      expect(result, Right(registeredMobile));
      verify(() => mockLocal.getRegisteredMobile()).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockLocal.getRegisteredMobile(),
      ).thenThrow(Exception('Cache error'));

      final result = await repository.getRegisteredMobile();

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });

  group('resetPassword', () {
    const mobileNumber = '01700000000';
    const newPassword = 'new_password';
    const response = 'Password reset successful';

    test('should return Right(String) on success', () async {
      when(
        () => mockRemote.resetPassword(
          mobileNumber: mobileNumber,
          password: newPassword,
        ),
      ).thenAnswer((_) async => response);

      final result = await repository.resetPassword(
        mobileNumber: mobileNumber,
        password: newPassword,
      );

      expect(result, Right(response));
      verify(
        () => mockRemote.resetPassword(
          mobileNumber: mobileNumber,
          password: newPassword,
        ),
      ).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.resetPassword(
          mobileNumber: mobileNumber,
          password: newPassword,
        ),
      ).thenThrow(Exception('Reset failed'));

      final result = await repository.resetPassword(
        mobileNumber: mobileNumber,
        password: newPassword,
      );

      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (_) => null), isA<Failure>());
    });
  });
}
