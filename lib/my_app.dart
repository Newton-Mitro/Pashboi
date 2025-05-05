import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/themes/app_theme.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:pashboi/features/under_maintanance/presentation/pages/under_maintanance_page.dart';
import 'package:pashboi/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

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
      builder: (localeContext, languageState) {
        return BlocConsumer<ThemeBloc, ThemeState>(
          listener: (context, state) {},
          builder: (context, themeState) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              darkTheme: AppTheme().dark,
              theme: AppTheme().light,
              navigatorKey: navigatorKey,
              themeMode:
                  themeState is LightThemeState
                      ? ThemeMode.light
                      : ThemeMode.dark,
              supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
              localizationsDelegates: Locales.delegates,
              locale: Locale(languageState.language, 'bn'),
              navigatorObservers: [routeObserver],
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
