import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:pashboi/injection.dart';
import 'package:pashboi/features/my_app/presentation/pages/my_app.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'bn']);
  await setupDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LanguageBloc>()..add(LoadLocaleEvent())),
        BlocProvider(create: (_) => sl<ThemeBloc>()..add(LoadTheme())),
        BlocProvider(create: (_) => sl<OnboardingPageBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}
