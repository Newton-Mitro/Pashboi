import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/data/models/auth_user_model.dart';
import 'package:pashboi/features/auth/domain/usecases/get_auth_user_usecase.dart';
import 'package:pashboi/features/authenticated/user/domain/entities/user_entity.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetAuthUserUseCase useCase;

  const tEmail = 'test@example.com';

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

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetAuthUserUseCase(authRepository: mockAuthRepository);
  });

  test('should return Right(AuthUserEntity) when successful', () async {
    // arrange
    when(
      () => mockAuthRepository.getAuthUser(),
    ).thenAnswer((_) async => Right(tUserEntity));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Right(tUserEntity));
    verify(() => mockAuthRepository.getAuthUser()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Left(Failure) when an error occurs', () async {
    // arrange
    final tFailure = CacheFailure(message: 'No user found in cache');
    when(
      () => mockAuthRepository.getAuthUser(),
    ).thenAnswer((_) async => Left(tFailure));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Left(tFailure));
    verify(() => mockAuthRepository.getAuthUser()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
