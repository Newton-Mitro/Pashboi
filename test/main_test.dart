import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/core/services/local_storage/local_storage.dart';

class MockLocalStorage extends Mock implements LocalStorage {}

void main() {
  // late MockLocalStorage mockLocalStorage;

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
