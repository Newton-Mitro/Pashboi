import 'package:pashboi/features/authenticated/cards/injection.dart';
import 'package:pashboi/features/authenticated/family_and_friends/injection.dart';
import 'package:pashboi/features/authenticated/my_accounts/injection.dart';
import 'package:pashboi/features/my_app/injection.dart';
import 'package:pashboi/features/onboarding/injection.dart';

import 'core/injection.dart';
import 'features/auth/injection.dart';

Future<void> setupDependencies() async {
  await registerCoreServices(); // Core services
  registerOnboardingModule(); // Onboarding module
  registerAppStatusModule(); // MyApp module
  registerCardModule();
  registerFamilyAndFriendsModule();
  registerAuthModule(); // Auth module
  registerMyAccountsModule();
}
