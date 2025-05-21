import 'package:pashboi/core/types/typedef.dart';
import 'package:pashboi/features/auth/domain/entities/auth_user_entity.dart';

abstract class AuthRepository {
  ResultFuture<String> register(
    String email,
    String password,
    String confirmPassword,
    String requestFrom,
  );
  ResultFuture<AuthUserEntity> login(String email, String password);
  ResultFuture<void> logout();
  ResultFuture<AuthUserEntity> getAuthUser();

  ResultFuture<String> verifyMobileNumber(
    String mobileNumber,
    bool isRegistered,
    String requestFrom,
  );

  ResultFuture<String> verifyOtp(
    String otpRegId,
    String otpValue,
    String mobileNumber,
    String requestFrom,
  );
}
