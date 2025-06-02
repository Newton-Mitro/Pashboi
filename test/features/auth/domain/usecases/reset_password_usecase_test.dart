import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/domain/usecases/reset_password_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late ResetPasswordUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = ResetPasswordUseCase(authRepository: mockAuthRepository);
  });

  const tMobileNumber = '01700000000';
  const tPassword = 'newSecurePass123';
  final tParams = ResetPasswordParams(
    mobileNumber: tMobileNumber,
    password: tPassword,
  );

  test('should return Right<void> when password reset is successful', () async {
    // arrange
    when(
      () => mockAuthRepository.resetPassword(
        mobileNumber: any(named: 'mobileNumber'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Right('Password reset successful'));

    // act
    final result = await useCase(tParams);

    // assert
    expect(result, const Right('Password reset successful'));
    verify(
      () => mockAuthRepository.resetPassword(
        mobileNumber: tMobileNumber,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test(
    'should return Left<Failure> when an error occurs during password reset',
    () async {
      // arrange
      final tFailure = ServerFailure(message: 'Reset failed');
      when(
        () => mockAuthRepository.resetPassword(
          mobileNumber: any(named: 'mobileNumber'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Left(tFailure));

      // act
      final result = await useCase(tParams);

      // assert
      expect(result, Left(tFailure));
      verify(
        () => mockAuthRepository.resetPassword(
          mobileNumber: tMobileNumber,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
