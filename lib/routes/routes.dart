import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/add_beneficiary_page.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/beneficiaries_page.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/presentation/bloc/collection_ledger_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/add_operating_account_page/add_operating_account_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/dependents_page/bloc/fetch_dependents_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/dependents_page/dependents_page.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/add_family_and_relative_page.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/card_page.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/add_family_and_friend_bloc/add_family_and_friend_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_friend_bloc/relationship_bloc/relationship_bloc.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_relatives_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_details_page/account_details_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/account_openning_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/my_account_page/my_accounts_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/operating_accounts_page/bloc/fetch_operating_accounts_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/operating_accounts_page/operating_accounts_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_details_page/loan_details_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/my_loans_page/my_loans_page.dart';
import 'package:pashboi/features/authenticated/sureties/presentation/pages/given_sureties_page.dart';
import 'package:pashboi/features/authenticated/profile/presentation/pages/profile_page.dart';
import 'package:pashboi/features/public/public_home/views/public_home.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
import 'package:pashboi/features/authenticated/authenticated_home/views/authenticated_home.dart';
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

      // Authenticated Routes
      case AuthRoutesName.profilePage:
        return _materialRoute(ProfilePage());

      case AuthRoutesName.cardPage:
        return _materialRoute(CardPage());

      case AuthRoutesName.familyAndRelativesPage:
        return _materialRoute(FamilyAndRelativesPage());

      case AuthRoutesName.addFamilyMemberPage:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CollectionLedgerBloc>()),
              BlocProvider(create: (context) => sl<RelationshipBloc>()),
              BlocProvider(create: (context) => sl<AddFamilyAndFriendBloc>()),
            ],
            child: AddFamilyAndRelativesPage(),
          ),
        );

      case AuthRoutesName.suretiesPage:
        return _materialRoute(GivenSuretiesPage());

      case AuthRoutesName.beneficiariesPage:
        return _materialRoute(BeneficiariesPage());
      case AuthRoutesName.addBeneficiaryPage:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CollectionLedgerBloc>()),
            ],
            child: AddBeneficiaryPage(),
          ),
        );

      case AuthRoutesName.dependentsPage:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<FetchDependentsBloc>()),
              BlocProvider(
                create: (context) => sl<FetchOperatingAccountsBloc>(),
              ),
            ],
            child: DependentsPage(),
          ),
        );
      case AuthRoutesName.operatingAccountsPage:
        if (args is Map<String, int>) {
          final dependentPersonId = args['dependentPersonId'] ?? 0;

          return _materialRoute(
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<FetchOperatingAccountsBloc>(),
                ),
              ],
              child: DependentsAccountsPage(
                dependentPersonId: dependentPersonId,
              ),
            ),
          );
        } else {
          return _materialRoute(
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<FetchOperatingAccountsBloc>(),
                ),
              ],
              child: DependentsAccountsPage(dependentPersonId: 0),
            ),
          );
        }

      case AuthRoutesName.addOperatingAccountPage:
        return _materialRoute(AddOperatingAccountPage());

      case AuthRoutesName.myAccountsPage:
        return _materialRoute(MyAccountsPage());

      case AuthRoutesName.accountsDetailsPage:
        if (args is Map<String, String>) {
          final accountNumber = args['accountNumber'] ?? '';

          return _materialRoute(
            AccountDetailsPage(accountNumber: accountNumber),
          );
        } else {
          return _materialRoute(AccountDetailsPage(accountNumber: ""));
        }

      case AuthRoutesName.createNewAccountPage:
        return _materialRoute(AccountOpeningPage());

      case AuthRoutesName.myLoansPage:
        return _materialRoute(MyLoansPage());
      case AuthRoutesName.loanDetailsPage:
        if (args is Map<String, String>) {
          final loanNumber = args['loanNumber'] ?? '';

          return _materialRoute(LoanDetailsPage(loanNumber: loanNumber));
        } else {
          return _materialRoute(LoanDetailsPage(loanNumber: ""));
        }

      default:
        return _materialRoute(const AuthenticatedHome());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
