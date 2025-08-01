import 'package:pashboi/features/authenticated/beneficiaries/injection.dart';
import 'package:pashboi/features/authenticated/cards/injection.dart';
import 'package:pashboi/features/authenticated/collection_ledgers/injection.dart';
import 'package:pashboi/features/authenticated/deposit/injection.dart';
import 'package:pashboi/features/authenticated/family_and_friends/injection.dart';
import 'package:pashboi/features/authenticated/loan_payment/injection.dart';
import 'package:pashboi/features/authenticated/my_accounts/injection.dart';
import 'package:pashboi/features/authenticated/my_loans/injection.dart';
import 'package:pashboi/features/authenticated/profile/injection.dart';
import 'package:pashboi/features/authenticated/sureties/injection.dart';
import 'package:pashboi/features/my_app/injection.dart';
import 'package:pashboi/features/onboarding/injection.dart';
import 'package:pashboi/features/public/deposit_policies/injection.dart';
import 'package:pashboi/features/public/development_credits/injection.dart';
import 'package:pashboi/features/public/loan_policies/injection.dart';
import 'package:pashboi/features/public/notice/injection.dart';
import 'package:pashboi/features/public/pages/injection.dart';
import 'package:pashboi/features/public/project/injection.dart';
import 'package:pashboi/features/public/service/injection.dart';
import 'package:pashboi/features/public/service_centers/injection.dart';

import 'core/injection.dart';
import 'features/auth/injection.dart';

Future<void> setupDependencies() async {
  await registerCoreServices();
  registerOnboardingModule();
  registerAppStatusModule();
  registerCardModule();
  registerFamilyAndFriendsModule();
  registerAuthModule();
  registerMyAccountsModule();
  registerProfileModule();
  registerDepositPolicyModule();
  registerSuretyModule();
  registerLoanPolicyModule();
  registerBeneficiaryModule();
  registerNoticeModule();
  registerCollectionLedgerModule();
  registerServicePolicyModule();
  registerProjectModule();
  registerServiceCenterModule();
  registerLoanModule();
  registerPageModule();
  registerDevelopmentCreditModule();
  registerDepositModule();
  registerLoanPaymentModule();
}
