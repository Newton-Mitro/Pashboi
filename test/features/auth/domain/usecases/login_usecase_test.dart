import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';
import 'package:pashboi/features/authenticated/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/auth/domain/usecases/login_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late LoginUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = LoginUseCase(authRepository: mockRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tHashedPassword = md5.convert(utf8.encode(tPassword)).toString();

  final tUserEntity = AuthUserModel(
    accessToken: 'mockAccessToken',
    refreshToken: 'mockRefreshToken',
    user: UserEntity(
      id: 'uuid-123',
      userId: 1,
      personId: 1,
      loginEmail: tEmail,
      roleId: 'admin',
      roleName: 'Administrator',
      userName: 'Test User',
      userPicture: '',
      branchCode: 'BR001',
      regMobile: '01700000000',
      address: '123 Street',
      organizationCode: 'ORG001',
      deviceId: 12345,
      employeeCode: 'EMP001',
      isNewMenu: false,
      accessToken: 'token_abc123',
      rolePermissions: [],
    ),
  );

  test('should return UserEntity on successful login', () async {
    // arrange
    when(
      () => mockRepository.login(tEmail, tHashedPassword),
    ).thenAnswer((_) async => Right(tUserEntity));

    // act
    final result = await useCase(
      LoginParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, Right(tUserEntity));
    verify(() => mockRepository.login(tEmail, tHashedPassword)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure on failed login', () async {
    // arrange
    when(() => mockRepository.login(tEmail, tHashedPassword)).thenAnswer(
      (_) async => const Left(UnauthorizedFailure(message: 'Login failed')),
    );

    // act
    final result = await useCase(
      LoginParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (_) => null), isA<Failure>());
    verify(() => mockRepository.login(tEmail, tHashedPassword)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
