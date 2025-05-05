import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pashboi/my_app.dart';
import 'package:pashboi/features/landing/presentation/pages/landing_page.dart';
import 'package:pashboi/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:pashboi/features/under_maintanance/presentation/pages/under_maintanance_page.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/core/utils/local_storage.dart';

// Mock the LocalStorage class
class MockLocalStorage extends Mock implements LocalStorage {}

class MockMyService extends Mock {
  // Mocking the isUnderConstructionFn callback (nullable function)
  Future<bool> Function()? isUnderConstructionFn;

  // Mocking the isUnderConstruction method
  Future<bool> isUnderConstruction() async {
    return await (isUnderConstructionFn?.call() ?? Future.value(false));
  }
}

void main() {
  late MockLocalStorage mockLocalStorage;
  late MockMyService mockService;

  setUp(() {
    mockLocalStorage = MockLocalStorage();
    when(() => mockLocalStorage.getString(any())).thenAnswer((_) async => 'en');
    mockService = MockMyService();
  });

  Widget wrapApp(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create:
              (_) =>
                  LanguageBloc(localStorage: mockLocalStorage)
                    ..add(LoadLocaleEvent()),
        ),
        BlocProvider<ThemeBloc>(
          create:
              (_) =>
                  ThemeBloc(localStorage: mockLocalStorage)
                    ..add(LoadThemeEvent()),
        ),
      ],
      child: child,
    );
  }

  testWidgets(
    'shows LandingPage when not under construction and not onboarding',
    (tester) async {
      // Mock the under construction function to return false
      mockService.isUnderConstructionFn = () async => false;

      await tester.pumpWidget(
        wrapApp(
          MyApp(
            onBoarding: false,
            isUnderConstructionFn: mockService.isUnderConstructionFn,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(LandingPage), findsOneWidget);
    },
  );

  testWidgets(
    'shows OnboardingPage when not under construction and onboarding is true',
    (tester) async {
      // Mock the under construction function to return false
      mockService.isUnderConstructionFn = () async => false;

      await tester.pumpWidget(
        wrapApp(
          MyApp(
            onBoarding: true,
            isUnderConstructionFn: mockService.isUnderConstructionFn,
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);
    },
  );

  testWidgets('shows UnderMaintenancePage when under construction', (
    tester,
  ) async {
    // Mock the under construction function to return true
    mockService.isUnderConstructionFn = () async => true;

    await tester.pumpWidget(
      wrapApp(
        MyApp(
          onBoarding: false,
          isUnderConstructionFn: mockService.isUnderConstructionFn,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(UnderMaintenancePage), findsOneWidget);
  });
}
