import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/pages/login_page.dart';
import 'package:pashboi/features/auth/presentation/pages/registration_page.dart';
import 'package:pashboi/features/auth/presentation/pages/reset_password_page.dart';
import 'package:pashboi/features/auth/presentation/pages/mobile_verification_page.dart';
import 'package:pashboi/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/add_beneficiary_bloc/add_beneficiary_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_later_page/bloc/deposit_later_steps_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_later_page/deposit_later_page.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/bloc/deposit_now_steps_bloc.dart';
import 'package:pashboi/features/authenticated/deposit/presentation/pages/deposit_now_page/deposit_now_page.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/bloc/add_family_and_relative_bloc/add_family_and_relative_bloc.dart';
import 'package:pashboi/features/authenticated/loan_payment/presentation/pages/bloc/loan_payment_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/account_statement_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/account_opening_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/bloc/account_opening_steps_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/bloc/tenure_amount_bloc/tenure_amount_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_openning_page/parts/account_opening_details_section/bloc/tenure_bloc/tenure_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_statement_page/bloc/account_statement_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/openable_accounts_page/bloc/openable_account_bloc.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/openable_accounts_page/openable_accounts_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/loan_statement_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_statement_section/bloc/loan_statement_bloc.dart';
import 'package:pashboi/features/authenticated/profile/presentation/change_password/page/change_password_page.dart';
import 'package:pashboi/features/authenticated/profile/presentation/profile_page/bloc/profile_bloc.dart';
import 'package:pashboi/features/authenticated/profile/presentation/profile_page/page/profile_page.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/deposit_policies/presentation/pages/deposit_policy_details_page.dart';
import 'package:pashboi/features/public/development_credits/domain/entites/development_credits_entity.dart';
import 'package:pashboi/features/public/development_credits/presentation/pages/development_creadit_details.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/presentation/pages/loan_policy_details_page.dart';
import 'package:pashboi/features/public/notice/domain/enities/notice_entity.dart';
import 'package:pashboi/features/public/notice/presentation/pages/notice_details_page.dart';
import 'package:pashboi/features/public/project/domain/entites/project_entity.dart';
import 'package:pashboi/features/public/project/presentation/pages/project_details_page.dart';
import 'package:pashboi/features/public/public_home/views/public_home.dart';
import 'package:pashboi/features/authenticated/authenticated_shared/views/authenticated_home.dart';
import 'package:pashboi/features/authenticated/cards/presentation/pages/card_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/my_loans_page/my_loans_page.dart';
import 'package:pashboi/features/authenticated/my_loans/presentation/pages/loan_details_page/loan_details_page.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/family_and_relatives_page.dart';
import 'package:pashboi/features/authenticated/family_and_friends/presentation/pages/add_family_and_relative_page.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/beneficiaries_page.dart';
import 'package:pashboi/features/authenticated/beneficiaries/presentation/pages/add_beneficiary_page.dart';
import 'package:pashboi/features/authenticated/sureties/presentation/pages/given_sureties_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/my_account_page/my_accounts_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/account_details_page/account_details_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/operating_accounts_page/operating_accounts_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/dependents_page/dependents_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/add_operating_account_page/add_operating_account_page.dart';
import 'package:pashboi/features/authenticated/my_accounts/presentation/pages/add_operating_account_page/bloc/add_operating_account_bloc.dart';
import 'package:pashboi/features/public/service/domain/enities/service_policy_entity.dart';
import 'package:pashboi/features/public/service/presentation/service_policy_details_page.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/routes/auth_routes_name.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    final args = settings.arguments;

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
          return _materialRoute(
            MobileVerificationPage(
              routeName: args['routeName'] ?? '',
              pageTitle: args['pageTitle'] ?? '',
            ),
          );
        }
        break;

      case PublicRoutesName.otpVerificationPage:
        if (args is Map<String, String>) {
          return _materialRoute(
            OtpVerificationPage(
              routeName: args['routeName'] ?? '',
              mobileNumber: args['mobileNumber'] ?? '',
              otpRegId: args['otpRegId'] ?? '',
            ),
          );
        }
        break;

      case PublicRoutesName.savingPolicyDetailsPage:
        if (args is Map<String, DepositPolicyEntity?>) {
          return _materialRoute(
            DepositPolicyDetailsPage(depositPolicy: args['depositPolicy']!),
          );
        }
        break;

      case PublicRoutesName.loanPoliciesDetailsPage:
        if (args is Map<String, LoanPolicyEntity?>) {
          return _materialRoute(
            LoanPolicyDetailsPage(loanPolicy: args['loanPolicy']!),
          );
        }
        break;

      case PublicRoutesName.noticesDetailsPage:
        if (args is Map<String, NoticeEntity?>) {
          return _materialRoute(NoticeDetailsPage(notice: args['notice']!));
        }
        break;

      case PublicRoutesName.serviceDetailsPage:
        if (args is Map<String, ServicePolicyEntity?>) {
          return _materialRoute(
            ServicePolicyDetailsPage(service: args['service']!),
          );
        }
        break;

      case PublicRoutesName.projectDetailsPage:
        if (args is Map<String, ProjectEntity?>) {
          return _materialRoute(ProjectDetailsPage(project: args['projects']!));
        }
        break;
      case PublicRoutesName.developmentTeamsDetailsPage:
        if (args is Map<String, DevelopmentCreditsEntity?>) {
          return _materialRoute(
            DevelopmentCreditDetails(credit: args['developmentTeams']!),
          );
        }
        break;

      // Authenticated Routes
      case AuthRoutesName.profilePage:
        return _materialRoute(
          BlocProvider(create: (_) => sl<ProfileBloc>(), child: ProfilePage()),
        );

      case AuthRoutesName.cardPage:
        return _materialRoute(CardPage());

      case AuthRoutesName.familyAndRelativesPage:
        return _materialRoute(FamilyAndRelativesPage());

      case AuthRoutesName.addFamilyMemberPage:
        return _materialRoute(
          BlocProvider(
            create: (context) => sl<AddFamilyAndRelativeBloc>(),
            child: AddFamilyAndRelativesPage(),
          ),
        );

      case AuthRoutesName.suretiesPage:
        return _materialRoute(GivenSuretiesPage());

      case AuthRoutesName.beneficiariesPage:
        return _materialRoute(BeneficiariesPage());

      case AuthRoutesName.addBeneficiaryPage:
        return _materialRoute(
          BlocProvider(
            create: (context) => sl<AddBeneficiaryBloc>(),
            child: AddBeneficiaryPage(),
          ),
        );

      case AuthRoutesName.dependentsPage:
        return _materialRoute(DependentsPage());

      case AuthRoutesName.changePasswordPage:
        return _materialRoute(ChangePasswordPage());

      case AuthRoutesName.operatingAccountsPage:
        if (args is Map<String, int>) {
          return _materialRoute(
            BlocProvider(
              create: (_) => sl<AddOperatingAccountBloc>(),
              child: DependentsAccountsPage(
                dependentPersonId: args['dependentPersonId'] ?? 0,
              ),
            ),
          );
        }
        break;

      case AuthRoutesName.addOperatingAccountPage:
        return _materialRoute(
          BlocProvider(
            create: (_) => sl<AddOperatingAccountBloc>(),
            child: AddOperatingAccountPage(),
          ),
        );

      case AuthRoutesName.myAccountsPage:
        return _materialRoute(MyAccountsPage());

      case AuthRoutesName.accountsDetailsPage:
        if (args is Map<String, String>) {
          return _materialRoute(
            AccountDetailsPage(accountNumber: args['accountNumber'] ?? ''),
          );
        }
        break;

      case AuthRoutesName.accountStatement:
        if (args is Map<String, String>) {
          return _materialRoute(
            BlocProvider(
              create: (context) => sl<AccountStatementBloc>(),
              child: AccountStatementPage(
                accountNumber: args['accountNumber'] ?? '',
              ),
            ),
          );
        }
        break;

      case AuthRoutesName.openableAccountsPage:
        return _materialRoute(
          BlocProvider(
            create: (context) => sl<OpenableAccountBloc>(),
            child: OpenableAccountsPage(),
          ),
        );

      case AuthRoutesName.createNewAccountPage:
        if (args is Map<String, String>) {
          return _materialRoute(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<AccountOpeningStepsBloc>()),
                BlocProvider(create: (_) => sl<TenureBloc>()),
                BlocProvider(create: (_) => sl<TenureAmountBloc>()),
              ],
              child: AccountOpeningPage(
                productCode: args['productCode'] ?? '18',
                productName: args['productName'] ?? 'Savings Account',
              ),
            ),
          );
        }

      case AuthRoutesName.myLoansPage:
        return _materialRoute(MyLoansPage());

      case AuthRoutesName.loanDetailsPage:
        if (args is Map<String, String>) {
          return _materialRoute(
            LoanDetailsPage(loanNumber: args['loanNumber'] ?? ''),
          );
        }
        break;

      case AuthRoutesName.depositNowPage:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<DepositNowStepsBloc>()),
              BlocProvider(create: (context) => sl<LoanPaymentBloc>()),
            ],
            child: DepositNowPage(),
          ),
        );

      case AuthRoutesName.depositLaterPage:
        return _materialRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<DepositLaterStepsBloc>()),
              BlocProvider(create: (context) => sl<LoanPaymentBloc>()),
            ],
            child: DepositLaterPage(),
          ),
        );

      case AuthRoutesName.loanStatement:
        if (args is Map<String, String>) {
          return _materialRoute(
            BlocProvider(
              create: (context) => sl<LoanStatementBloc>(),
              child: LoanStatementPage(loanNumber: args['loanNumber'] ?? ''),
            ),
          );
        }
        break;
      default:
        return _materialRoute(const AuthenticatedHome());
    }

    // Fallback if args are wrong
    return _materialRoute(const AuthenticatedHome());
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
