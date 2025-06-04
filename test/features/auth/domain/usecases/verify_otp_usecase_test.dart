import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/domain/usecases/verify_otp_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late VerifyOtpUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = VerifyOtpUseCase(authRepository: mockAuthRepository);
  });

  const testOtpRegId = 'reg123';
  const testOtpValue = '123456';
  const testMobileNumber = '01700000000';
  const expectedResult = 'VERIFIED';

  final testParams = VerifyOtpParams(
    otpRegId: testOtpRegId,
    otpValue: testOtpValue,
    mobileNumber: testMobileNumber,
  );

  test(
    'should return a String result on successful OTP verification',
    () async {
      // arrange
      when(
        () => mockAuthRepository.verifyOtp(
          testOtpRegId,
          testOtpValue,
          testMobileNumber,
        ),
      ).thenAnswer((_) async => Right(expectedResult));

      // act
      final result = await useCase(testParams);

      // assert
      expect(result, Right(expectedResult));
      verify(
        () => mockAuthRepository.verifyOtp(
          testOtpRegId,
          testOtpValue,
          testMobileNumber,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );

  test('should return Failure on unsuccessful OTP verification', () async {
    // arrange
    when(
      () => mockAuthRepository.verifyOtp(
        testOtpRegId,
        testOtpValue,
        testMobileNumber,
      ),
    ).thenAnswer(
      (_) async => const Left(ServerFailure(message: 'Verification failed')),
    );

    // act
    final result = await useCase(testParams);

    // assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (_) => null), isA<Failure>());
    verify(
      () => mockAuthRepository.verifyOtp(
        testOtpRegId,
        testOtpValue,
        testMobileNumber,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
