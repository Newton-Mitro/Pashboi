import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class VerifyMobileNumberParams {
  final String mobileNumber;
  final bool isRegistered;
  final String requestFrom;

  VerifyMobileNumberParams({
    required this.mobileNumber,
    required this.isRegistered,
    required this.requestFrom,
  });
}

class VerifyMobileNumberUseCase
    extends UseCase<String, VerifyMobileNumberParams> {
  final AuthRepository authRepository;

  VerifyMobileNumberUseCase({required this.authRepository});

  @override
  ResultFuture<String> call(VerifyMobileNumberParams params) async {
    final authUser = await authRepository.verifyMobileNumber(
      params.mobileNumber,
      params.isRegistered,
      params.requestFrom,
    );

    return authUser;
  }
}
