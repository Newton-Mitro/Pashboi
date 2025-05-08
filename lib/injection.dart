import 'package:pashboi/features/onboarding/injection.dart';

import 'core/injection.dart';
import 'features/auth/injection.dart';

Future<void> setupDependencies() async {
  await registerCoreServices(); // Core services
  registerAuthModule(); // Auth module
  registerOnboardingModule(); // Onboarding module
}
