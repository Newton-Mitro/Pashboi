import 'package:pashboi/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase({required this.authRepository});

  Future<void> call(String mobileNumber) async {
    // return repository.sendForgotPasswordOTP(mobileNumber);
    // Temporarily simulate a network delay or action
    await Future.delayed(Duration(seconds: 1));
    return;
  }
}
