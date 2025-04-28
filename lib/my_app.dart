import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pashboi/app_configs/themes/app_theme.dart';
import 'package:pashboi/core/index.dart';
import 'package:pashboi/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/features/landing/landing_page.dart';
import 'package:pashboi/features/onboarding/presentation/views/onboarding_screen.dart';
import 'package:pashboi/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool onBoarding;
  const MyApp({super.key, required this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return BlocConsumer<ThemeBloc, ThemeState>(
          listener: (context, state) {},
          builder: (context, themeState) {
            return MaterialApp(
              title: context.appLocalizations.appName,
              debugShowCheckedModeBanner: false,
              darkTheme: AppTheme().dark,
              theme: AppTheme().light,
              navigatorKey: navigatorKey,
              themeMode:
                  themeState is LightThemeState
                      ? ThemeMode.light
                      : ThemeMode.dark,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [Locale('en'), Locale('bn')],
              locale: Locale(languageState.language),
              home: onBoarding ? OnboardingScreen() : LandingPage(),
              onGenerateRoute: AppRoutes().onGenerateRoutes,
            );
          },
        );
      },
    );
  }
}
