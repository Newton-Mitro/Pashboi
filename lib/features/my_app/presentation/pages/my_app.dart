import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/onboarding/presentation/bloc/onboarding_page_bloc.dart';
import 'package:pashboi/shared/themes/app_theme.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:pashboi/features/under_maintanance/presentation/pages/under_maintanance_page.dart';
import 'package:pashboi/routes/routes.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isUnderConstructionValue;
  bool? onBoardingValue;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    context.read<OnboardingPageBloc>().add(GetOnboardingSeenEvent());
    _loadStartupStatus();
  }

  Future<void> _loadStartupStatus() async {
    try {
      setState(() {
        isUnderConstructionValue = false;
      });
    } catch (_) {
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<OnboardingPageBloc, OnboardingPageState>(
              builder: (context, onboardingState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  navigatorKey: navigatorKey,
                  navigatorObservers: [routeObserver],
                  themeMode:
                      themeState is LightThemeState
                          ? ThemeMode.light
                          : ThemeMode.dark,
                  theme: appTheme.lightPrimary,
                  darkTheme: appTheme.darkPrimary,
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('bn', 'BD'),
                  ],
                  localizationsDelegates: Locales.delegates,
                  locale:
                      languageState.language == 'bn'
                          ? const Locale('bn', 'BD')
                          : const Locale('en', 'US'),
                  onGenerateRoute: AppRoutes().onGenerateRoutes,
                  initialRoute: '/',
                  home: _buildHome(
                    onboardingState,
                    isUnderConstructionValue ?? false,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildHome(OnboardingPageState state, bool isUnderConstruction) {
    if (isUnderConstruction) {
      return const UnderMaintenancePage();
    }

    if (state is OnboardingLoading || state is OnboardingPageInitial) {
      return const _LoadingScreen();
    }

    if (state is OnboardingError) {
      return _ErrorScreen(message: state.message);
    }

    if (state is OnboardingSeenLoaded) {
      final bool onboardingSeen = state.seen;

      return onboardingSeen ? const LandingPage() : const OnboardingPage();
    }

    return const _ErrorScreen(message: 'Unexpected state');
  }
}

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class _ErrorScreen extends StatelessWidget {
  final String message;
  const _ErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
