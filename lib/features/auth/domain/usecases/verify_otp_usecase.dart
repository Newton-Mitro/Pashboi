import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/core/usecases/usecase.dart';
import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

final class VerifyOtpParams {
  final String otpRegId;
  final String otpValue;
  final String mobileNumber;
  final String requestFrom;

  VerifyOtpParams({
    required this.otpRegId,
    required this.otpValue,
    required this.mobileNumber,
    required this.requestFrom,
  });
}

class VerifyOtpUseCase extends UseCase<String, VerifyOtpParams> {
  final AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});

  @override
  ResultFuture<String> call(VerifyOtpParams params) async {
    final authUser = await authRepository.verifyOtp(
      params.otpRegId,
      params.otpValue,
      params.mobileNumber,
      params.requestFrom,
    );

    return authUser;
  }
}
