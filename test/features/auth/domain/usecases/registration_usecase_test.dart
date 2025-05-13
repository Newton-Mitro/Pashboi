import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/domain/usecases/registration_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegistrationUseCase registrationUseCase;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tConfirmPassword = 'password123';
  const tRequestFrom = 'mobile';
  const tSuccessMessage = 'Registration successful';

  final tParams = RegistrationParams(
    email: tEmail,
    password: tPassword,
    confirmPassword: tConfirmPassword,
    requestFrom: tRequestFrom,
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registrationUseCase = RegistrationUseCase(
      authRepository: mockAuthRepository,
    );
  });

  test('should return success message on successful registration', () async {
    // Arrange
    when(
      () => mockAuthRepository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
        tRequestFrom,
      ),
    ).thenAnswer((_) async => Right(tSuccessMessage));

    // Act
    final result = await registrationUseCase(tParams);

    // Assert
    expect(result, Right(tSuccessMessage));
    verify(
      () => mockAuthRepository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
        tRequestFrom,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure on unsuccessful registration', () async {
    // Arrange
    when(
      () => mockAuthRepository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
        tRequestFrom,
      ),
    ).thenAnswer(
      (_) async => Left(ServerFailure(message: 'Registration failed')),
    );

    // Act
    final result = await registrationUseCase(tParams);

    // Assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (_) => null), isA<ServerFailure>());
    verify(
      () => mockAuthRepository.register(
        tEmail,
        tPassword,
        tConfirmPassword,
        tRequestFrom,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
