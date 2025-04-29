import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/features/auth/presentation/views/login_screen/views/login_screen.dart';
import 'package:pashboi/features/auth/presentation/views/registration_screen/views/register_screen.dart';
import 'package:pashboi/features/home/presentation/home_screen/view/home_screen.dart';
import 'package:pashboi/features/landing/landing_page.dart';
import 'package:pashboi/features/mobile_verification/mobile_verification_page.dart';
import 'package:pashboi/features/public_home/pages/public_home.dart';
import 'package:pashboi/features/user/domain/entities/user_entity.dart';
import 'package:pashboi/features/user/presentation/user_profile_screen/view/user_profile_screen.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case RoutesName.landingPage:
        return _materialRoute(LandingPage());

      case RoutesName.publicHomePage:
        return _materialRoute(PublicHome());

      case RoutesName.homePage:
        return _materialRoute(const HomeScreen());

      case RoutesName.loginPage:
        return _materialRoute(const LoginScreen());

      case RoutesName.registerPage:
        return _materialRoute(const RegistrationScreen());

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
        return _materialRoute(UserProfileScreen(user: args as UserEntity));

      default:
        return _materialRoute(const HomeScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
