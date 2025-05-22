import 'package:flutter/material.dart';
import 'package:pashboi/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
import 'package:pashboi/features/authenticated_pages/authenticated_home/views/authenticated_home.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/auth/presentation/pages/mobile_verification_page.dart';
import 'package:pashboi/features/public_pages/public_home/views/public_home.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case PublicRoutesName.landingPage:
        return _materialRoute(LandingPage());

      case PublicRoutesName.publicHomePage:
        return _materialRoute(PublicHome());

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
          final routeName =
              args['routeName'] ?? ''; // Extract the routeName from the map
          return _materialRoute(MobileVerificationPage(routeName: routeName));
        } else {
          return _materialRoute(
            const MobileVerificationPage(routeName: PublicRoutesName.loginPage),
          ); // Default route name if no arguments
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

      default:
        return _materialRoute(const AuthenticatedHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

// import 'package:flutter/material.dart';
// import 'package:pashboi/features/auth/presentation/pages/otp_verification_page.dart';
// import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
// import 'package:pashboi/routes/public_routes_name.dart';
// import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
// import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
// import 'package:pashboi/features/authenticated_home/views/authenticated_home.dart';
// import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
// import 'package:pashboi/features/auth/presentation/pages/mobile_verification_page.dart';
// import 'package:pashboi/features/public_home/views/public_home.dart';

// class AppRoutes {
//   Route<dynamic> onGenerateRoutes(RouteSettings settings) {
//     final Object? args = settings.arguments;

//     switch (settings.name) {
//       case PublicRoutesName.landingPage:
//         return _slideRightRoute(LandingPage());

//       case PublicRoutesName.publicHomePage:
//         return _slideRightRoute(PublicHome());

//       case PublicRoutesName.homePage:
//         return _slideRightRoute(AuthenticatedHome());

//       case PublicRoutesName.loginPage:
//         return _slideRightRoute(LoginPage());

//       case PublicRoutesName.registerPage:
//         return _slideRightRoute(RegistrationPage());

//       case PublicRoutesName.resetPasswordPage:
//         return _slideRightRoute(ResetPasswordPage());

//       case PublicRoutesName.mobileVerificationPage:
//         if (args is Map<String, String>) {
//           final routeName = args['routeName'] ?? '';
//           return _slideRightRoute(MobileVerificationPage(routeName: routeName));
//         } else {
//           return _slideRightRoute(
//             const MobileVerificationPage(routeName: PublicRoutesName.loginPage),
//           );
//         }

//       case PublicRoutesName.otpVerificationPage:
//         if (args is Map<String, String>) {
//           final routeName = args['routeName'] ?? '';
//           final mobileNumber = args['mobileNumber'] ?? '';
//           final otpRegId = args['otpRegId'] ?? '';
//           return _slideRightRoute(
//             OtpVerificationPage(
//               routeName: routeName,
//               mobileNumber: mobileNumber,
//               otpRegId: otpRegId,
//             ),
//           );
//         } else {
//           return _slideRightRoute(
//             const OtpVerificationPage(
//               routeName: PublicRoutesName.loginPage,
//               mobileNumber: '',
//               otpRegId: '',
//             ),
//           );
//         }

//       default:
//         return _slideRightRoute(const AuthenticatedHome());
//     }
//   }

//   static Route<dynamic> _slideRightRoute(Widget view) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => view,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0); // From right
//         const end = Offset.zero;
//         const exitBegin = Offset.zero;
//         const exitEnd = Offset(-1.0, 0.0); // Slide out to left

//         final enterTween = Tween(
//           begin: begin,
//           end: end,
//         ).chain(CurveTween(curve: Curves.easeInOut));
//         final exitTween = Tween(
//           begin: exitBegin,
//           end: exitEnd,
//         ).chain(CurveTween(curve: Curves.easeInOut));

//         return SlideTransition(
//           position: animation.drive(enterTween),
//           child: SlideTransition(
//             position: secondaryAnimation.drive(exitTween),
//             child: child,
//           ),
//         );
//       },
//     );
//   }
// }
