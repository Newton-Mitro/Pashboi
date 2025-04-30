import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pashboi/app_configs/themes/app_theme.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/pages/public/landing_page/views/landing_page.dart';
import 'package:pashboi/pages/public/onboarding_page/views/onboarding_page.dart';
import 'package:pashboi/pages/public/under_maintanance_page/views/under_maintanance_page.dart';
import 'package:pashboi/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final Future<bool> Function()? isUnderConstructionFn;

  const MyApp({
    super.key,
    required this.onBoarding,
    this.isUnderConstructionFn,
  });

  Future<bool> isUnderConstruction() async {
    return await (isUnderConstructionFn?.call() ?? Future.value(false));
  }

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
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en'), Locale('bn')],
              locale: Locale(languageState.language),
              home: FutureBuilder<bool>(
                future: isUnderConstruction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(child: Text("Something went wrong")),
                    );
                  }

                  final underConstruction = snapshot.data ?? false;

                  if (underConstruction) {
                    return UnderMaintenancePage();
                  }

                  return onBoarding
                      ? const OnboardingPage()
                      : const LandingPage();
                },
              ),
              onGenerateRoute: AppRoutes().onGenerateRoutes,
            );
          },
        );
      },
    );
  }
}
