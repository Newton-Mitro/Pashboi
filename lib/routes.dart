import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/pages/public/login_page/views/login_page.dart';
import 'package:pashboi/pages/public/register_page/views/register_page.dart';
import 'package:pashboi/pages/authenticated/home/views/authenticated_home.dart';
import 'package:pashboi/pages/public/landing_page/views/landing_page.dart';
import 'package:pashboi/pages/public/mobile_verification_page/views/mobile_verification_page.dart';
import 'package:pashboi/pages/public/home/views/public_home.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/pages/authenticated/profile_page/views/profile_page.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case RoutesName.landingPage:
        return _materialRoute(LandingPage());

      case RoutesName.publicHomePage:
        return _materialRoute(PublicHome());

      case RoutesName.homePage:
        return _materialRoute(const AuthenticatedHome());

      case RoutesName.loginPage:
        return _materialRoute(const LoginPage());

      case RoutesName.registerPage:
        return _materialRoute(const RegisterPage());

      case RoutesName.mobileVerificationPage:
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

      case RoutesName.userProfilePage:
        return _materialRoute(ProfilePage(user: args as UserEntity));

      default:
        return _materialRoute(const AuthenticatedHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
