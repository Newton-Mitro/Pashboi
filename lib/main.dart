import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pashboi/features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import 'package:pashboi/features/auth/presentation/bloc/otp_verification_bloc/otp_verification_bloc.dart';
import 'package:pashboi/features/my_app/presentation/bloc/my_app_bloc.dart';
import 'package:pashboi/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:pashboi/injection.dart';
import 'package:pashboi/features/my_app/presentation/pages/my_app.dart';
import 'package:pashboi/shared/widgets/language_switch/bloc/language_switch_bloc.dart';
import 'package:pashboi/shared/widgets/theme_selector/bloc/theme_selector_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Locales.init(['en', 'bn']);
  await setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<LanguageSwitchBloc>()..add(LoadLocaleEvent()),
        ),
        BlocProvider(create: (_) => sl<ThemeSelectorBloc>()..add(LoadTheme())),
        BlocProvider(create: (_) => sl<OnboardingPageBloc>()),
        BlocProvider(create: (_) => sl<AppStatusBloc>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<VerifyMobileNumberBloc>()),
        BlocProvider(create: (_) => sl<OtpVerificationBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
