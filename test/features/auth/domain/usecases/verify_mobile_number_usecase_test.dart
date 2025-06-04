import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/features/auth/domain/usecases/verify_mobile_number_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late VerifyMobileNumberUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = VerifyMobileNumberUseCase(authRepository: mockAuthRepository);
  });

  const testMobileNumber = '01700000000';
  const isRegistered = true;
  const expectedResult = 'OTP_SENT';

  final testParams = VerifyMobileNumberParams(
    mobileNumber: testMobileNumber,
    isRegistered: isRegistered,
  );

  test('should return a String result on successful verification', () async {
    // arrange
    when(
      () =>
          mockAuthRepository.verifyMobileNumber(testMobileNumber, isRegistered),
    ).thenAnswer((_) async => Right(expectedResult));

    // act
    final result = await useCase(testParams);

    // assert
    expect(result, Right(expectedResult));
    verify(
      () =>
          mockAuthRepository.verifyMobileNumber(testMobileNumber, isRegistered),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure on unsuccessful verification', () async {
    // arrange
    when(
      () =>
          mockAuthRepository.verifyMobileNumber(testMobileNumber, isRegistered),
    ).thenAnswer(
      (_) async => const Left(ServerFailure(message: 'Server error')),
    );

    // act
    final result = await useCase(testParams);

    // assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (_) => null), isA<Failure>());
    verify(
      () =>
          mockAuthRepository.verifyMobileNumber(testMobileNumber, isRegistered),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
