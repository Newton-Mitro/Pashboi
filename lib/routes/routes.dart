import 'package:flutter/material.dart';
import 'package:pashboi/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
import 'package:pashboi/features/authenticated_pages/user/presentation/pages/profile_page.dart';
import 'package:pashboi/features/public_pages/public_home/views/public_home.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/authenticated_home.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/auth/presentation/pages/mobile_verification_page.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      // Public Routes
      case PublicRoutesName.landingPage:
        return _materialRoute(LandingPage());

      case PublicRoutesName.publicRoot:
        return _materialRoute(PublicHomeScreen());

      case PublicRoutesName.homePage:
        return _materialRoute(AuthenticatedHome());

      case PublicRoutesName.loginPage:
        return _materialRoute(LoginPage());

      case PublicRoutesName.registerPage:
        return _materialRoute(RegistrationPage());

      case PublicRoutesName.resetPasswordPage:
        return _materialRoute(ResetPasswordPage());

      case PublicRoutesName.mobileVerificationPage:
        if (args is Map<String, String>) {
          final routeName = args['routeName'] ?? '';
          final pageTitle = args['pageTitle'] ?? '';
          return _materialRoute(
            MobileVerificationPage(routeName: routeName, pageTitle: pageTitle),
          );
        } else {
          return _materialRoute(
            const MobileVerificationPage(
              routeName: PublicRoutesName.loginPage,
              pageTitle: '',
            ),
          );
        }

      case PublicRoutesName.otpVerificationPage:
        if (args is Map<String, String>) {
          final routeName =
              args['routeName'] ?? ''; // Extract the routeName from the map
          final mobileNumber =
              args['mobileNumber'] ?? ''; // Extract the routeName from the map
          final otpRegId =
              args['otpRegId'] ?? ''; // Extract the routeName from the map
          return _materialRoute(
            OtpVerificationPage(
              routeName: routeName,
              mobileNumber: mobileNumber,
              otpRegId: otpRegId,
            ),
          );
        } else {
          return _materialRoute(
            const OtpVerificationPage(
              routeName: PublicRoutesName.loginPage,
              mobileNumber: '',
              otpRegId: '',
            ),
          ); // Default route name if no arguments
        }

      case AuthRoutesName.profilePage:
        return _materialRoute(ProfilePage());

      default:
        return _materialRoute(const AuthenticatedHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
