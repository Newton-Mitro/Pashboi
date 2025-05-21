import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/errors/failures.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/usecases/logout_usecase.dart';

import '../../../../mock.helper/mock.helper.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LogoutUseCase logoutUsecase;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logoutUsecase = LogoutUseCase(authRepository: mockAuthRepository);
  });

  test('should call logout on repository and return void on success', () async {
    // Arrange
    when(
      () => mockAuthRepository.logout(),
    ).thenAnswer((_) async => const Right(null));

    // Act
    final result = await logoutUsecase(NoParams());

    // Assert
    expect(result, const Right(null));
    verify(() => mockAuthRepository.logout()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure on logout error', () async {
    // Arrange
    when(
      () => mockAuthRepository.logout(),
    ).thenAnswer((_) async => Left(ServerFailure(message: 'Logout failed')));

    // Act
    final result = await logoutUsecase(NoParams());

    // Assert
    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (_) => null), isA<ServerFailure>());
    verify(() => mockAuthRepository.logout()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
