import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';
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

  final tUserModel = UserModel(
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
        () => mockRemote.register(tName, tEmail, tPassword, tConfirmPassword),
      ).thenAnswer((_) async => 'User registered successfully');

      final result = await repository.register(
        tName,
        tEmail,
        tPassword,
        tConfirmPassword,
      );

      expect(result, Right('User registered successfully'));
      verify(
        () => mockRemote.register(tName, tEmail, tPassword, tConfirmPassword),
      ).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(
        () => mockRemote.register(tName, tEmail, tPassword, tConfirmPassword),
      ).thenThrow(Exception('Registration failed'));

      final result = await repository.register(
        tName,
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
      when(() => mockRemote.logout()).thenAnswer((_) async => {});

      final result = await repository.logout();

      expect(result.isRight(), true);
      verify(() => mockRemote.logout()).called(1);
    });

    test('should return Left(Failure) on exception', () async {
      when(() => mockRemote.logout()).thenThrow(Exception('Logout failed'));

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
}
