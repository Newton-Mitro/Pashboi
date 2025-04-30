import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pashboi/my_app.dart';
import 'package:pashboi/pages/public/landing_page/views/landing_page.dart';
import 'package:pashboi/pages/public/under_maintanance_page/views/under_maintanance_page.dart';
import 'package:pashboi/pages/public/onboarding_page/views/onboarding_page.dart';
import 'package:pashboi/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/core/widgets/theme_switcher/bloc/theme_bloc.dart';

class MockLanguageBloc extends Mock implements LanguageBloc {}

class FakeLanguageState extends Fake implements LanguageState {}

class MockThemeBloc extends Mock implements ThemeBloc {}

class FakeThemeState extends Fake implements ThemeState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLanguageState());
    registerFallbackValue(FakeThemeState());
  });

  // testWidgets(
  //   'Shows LandingPage when not under construction and onboarding is false',
  //   (WidgetTester tester) async {
  //     final languageBloc = MockLanguageBloc();
  //     final themeBloc = MockThemeBloc();

  //     when(() => languageBloc.state).thenReturn(LanguageState(language: 'en'));
  //     when(() => themeBloc.state).thenReturn(LightThemeState());

  //     await tester.pumpWidget(
  //       MultiBlocProvider(
  //         providers: [
  //           BlocProvider<LanguageBloc>.value(value: languageBloc),
  //           BlocProvider<ThemeBloc>.value(value: themeBloc),
  //         ],
  //         child: MyApp(
  //           onBoarding: false,
  //           isUnderConstructionFn: () async => false,
  //         ),
  //       ),
  //     );

  //     await tester.pump(); // Start future
  //     await tester.pump(const Duration(seconds: 2)); // Wait for FutureBuilder

  //     expect(find.byType(LandingPage), findsOneWidget);
  //   },
  // );

  // testWidgets('Shows UnderMaintenancePage when under construction is true', (
  //   WidgetTester tester,
  // ) async {
  //   final languageBloc = MockLanguageBloc();
  //   final themeBloc = MockThemeBloc();

  //   when(() => languageBloc.state).thenReturn(LanguageState(language: 'en'));
  //   when(() => themeBloc.state).thenReturn(LightThemeState());

  //   await tester.pumpWidget(
  //     MultiBlocProvider(
  //       providers: [
  //         BlocProvider<LanguageBloc>.value(value: languageBloc),
  //         BlocProvider<ThemeBloc>.value(value: themeBloc),
  //       ],
  //       child: MyApp(
  //         onBoarding: false,
  //         isUnderConstructionFn: () async => true,
  //       ),
  //     ),
  //   );

  //   await tester.pump();
  //   await tester.pump(const Duration(seconds: 2));

  //   expect(find.byType(UnderMaintenancePage), findsOneWidget);
  // });

  // testWidgets('Shows OnboardingPage when onboarding is true', (
  //   WidgetTester tester,
  // ) async {
  //   final languageBloc = MockLanguageBloc();
  //   final themeBloc = MockThemeBloc();

  //   when(() => languageBloc.state).thenReturn(LanguageState(language: 'en'));
  //   when(() => themeBloc.state).thenReturn(LightThemeState());

  //   await tester.pumpWidget(
  //     MultiBlocProvider(
  //       providers: [
  //         BlocProvider<LanguageBloc>.value(value: languageBloc),
  //         BlocProvider<ThemeBloc>.value(value: themeBloc),
  //       ],
  //       child: MyApp(
  //         onBoarding: true,
  //         isUnderConstructionFn: () async => false,
  //       ),
  //     ),
  //   );

  //   await tester.pump();
  //   await tester.pump(const Duration(seconds: 5));

  //   expect(find.byType(OnboardingPage), findsOneWidget);
  // });
}
