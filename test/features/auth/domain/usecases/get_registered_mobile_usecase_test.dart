import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/get_registered_mobile_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late GetRegisteredMobileUseCase useCase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = GetRegisteredMobileUseCase(authRepository: mockAuthRepository);
  });

  const tMobile = '01700000000';

  test('should return Right<String> when successful', () async {
    // arrange
    when(
      () => mockAuthRepository.getRegisteredMobile(),
    ).thenAnswer((_) async => const Right(tMobile));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, const Right(tMobile));
    verify(() => mockAuthRepository.getRegisteredMobile()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Left<Failure> when an error occurs', () async {
    // arrange
    final tFailure = CacheFailure(message: 'No mobile found');
    when(
      () => mockAuthRepository.getRegisteredMobile(),
    ).thenAnswer((_) async => Left(tFailure));

    // act
    final result = await useCase(NoParams());

    // assert
    expect(result, Left(tFailure));
    verify(() => mockAuthRepository.getRegisteredMobile()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
