import 'package:flutter/material.dart';
import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
import 'package:pashboi/features/authenticated_home/views/authenticated_home.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/auth/presentation/pages/mobile_verification_page.dart';
import 'package:pashboi/features/public_home/views/public_home.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case PublicRoutesName.landingPage:
        return _materialRoute(LandingPage());

      case PublicRoutesName.publicHomePage:
        return _materialRoute(PublicHome());

      case PublicRoutesName.homePage:
        return _materialRoute(const AuthenticatedHome());

      case PublicRoutesName.loginPage:
        return _materialRoute(const LoginPage());

      case PublicRoutesName.registerPage:
        return _materialRoute(const RegistrationPage());

      case PublicRoutesName.resetPasswordPage:
        return _materialRoute(ResetPasswordPage());

      case PublicRoutesName.mobileVerificationPage:
        // Correctly extract the route name from arguments
        if (args is Map<String, String>) {
          final routeName =
              args['routeName'] ?? ''; // Extract the routeName from the map
          return _materialRoute(MobileVerificationPage(routeName: routeName));
        } else {
          return _materialRoute(
            const MobileVerificationPage(routeName: ''),
          ); // Default route name if no arguments
        }

      default:
        return _materialRoute(const AuthenticatedHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
