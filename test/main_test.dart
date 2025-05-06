import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/services/app_status_service.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:pashboi/features/under_maintanance/presentation/pages/under_maintanance_page.dart';
import 'package:pashboi/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';

class MockAppStatusService extends Mock implements AppStatusService {}

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  late MockAppStatusService mockAppStatusService;
  late MockLocalStorage mockLocalStorage;

  setUpAll(() async {
    await Locales.init(['en', 'bn']);
    // registerFallbackValue(LoadLocaleEvent());
    // registerFallbackValue(LoadThemeEvent());
  });

  // setUp(() {
  //   mockAppStatusService = MockAppStatusService();
  //   mockLocalStorage = MockLocalStorage();
  // });

  // Future<void> pumpApp(
  //   WidgetTester tester, {
  //   required bool isUnderConstruction,
  //   bool? onboardingValue,
  //   bool throwError = false,
  // }) async {
  //   if (throwError) {
  //     when(
  //       () => mockAppStatusService.isUnderConstruction(),
  //     ).thenThrow(Exception());
  //     when(() => mockLocalStorage.getBool(any())).thenThrow(Exception());
  //   } else {
  //     when(
  //       () => mockAppStatusService.isUnderConstruction(),
  //     ).thenAnswer((_) async => isUnderConstruction);
  //     when(
  //       () => mockLocalStorage.getBool(StorageKey.keyOnboarding),
  //     ).thenAnswer((_) async => onboardingValue);
  //     when(
  //       () => mockLocalStorage.getString(StorageKey.keyLocale),
  //     ).thenAnswer((_) async => 'en');
  //     when(
  //       () => mockLocalStorage.getString(StorageKey.keyTheme),
  //     ).thenAnswer((_) async => 'light');
  //   }

  //   await tester.pumpWidget(
  //     MultiBlocProvider(
  //       providers: [
  //         BlocProvider<LanguageBloc>(
  //           create:
  //               (_) =>
  //                   LanguageBloc(localeService: mockLocalStorage)
  //                     ..add(LoadLocaleEvent()),
  //         ),
  //         BlocProvider<ThemeBloc>(
  //           create:
  //               (_) =>
  //                   ThemeBloc(localStorage: mockLocalStorage)
  //                     ..add(LoadThemeEvent()),
  //         ),
  //       ],
  //       child: MaterialApp(
  //         supportedLocales: const [Locale('en', 'US'), Locale('bn', 'BD')],
  //         localizationsDelegates: Locales.delegates,
  //         home: Builder(
  //           builder: (context) {
  //             sl.registerSingleton<AppStatusService>(mockAppStatusService);
  //             sl.registerSingleton<LocalStorage>(mockLocalStorage);
  //             return const MyApp();
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // testWidgets('shows Loading screen initially', (tester) async {
  //   when(
  //     () => mockAppStatusService.isUnderConstruction(),
  //   ).thenAnswer((_) async => true);
  //   when(
  //     () => mockLocalStorage.getBool(StorageKey.keyOnboarding),
  //   ).thenAnswer((_) async => true);

  //   await pumpApp(tester, isUnderConstruction: true, onboardingValue: true);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(CircularProgressIndicator), findsOneWidget);
  // });

  // testWidgets('shows UnderMaintenancePage when under construction', (
  //   tester,
  // ) async {
  //   await pumpApp(tester, isUnderConstruction: true, onboardingValue: true);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(UnderMaintenancePage), findsOneWidget);
  // });

  // testWidgets('shows OnboardingPage if not completed', (tester) async {
  //   await pumpApp(tester, isUnderConstruction: false, onboardingValue: true);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(OnboardingPage), findsOneWidget);
  // });

  // testWidgets('shows LandingPage if onboarding completed', (tester) async {
  //   await pumpApp(tester, isUnderConstruction: false, onboardingValue: false);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(LandingPage), findsOneWidget);
  // });

  // testWidgets('shows Error screen on failure', (tester) async {
  //   await pumpApp(
  //     tester,
  //     isUnderConstruction: false,
  //     onboardingValue: false,
  //     throwError: true,
  //   );
  //   await tester.pumpAndSettle();

  //   expect(find.text('Something went wrong'), findsOneWidget);
  // });
}
