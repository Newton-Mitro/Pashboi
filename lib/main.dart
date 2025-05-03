import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/core/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/core/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/injection.dart';
import 'package:pashboi/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies(); // Register dependencies
  final localStorage = sl<LocalStorage>();

  final bool onBoarding =
      await localStorage.getBool(Constants.keyOnboarding) ?? true;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LanguageBloc>()..add(LoadLocaleEvent()),
        ),
        BlocProvider(
          create: (context) => sl<ThemeBloc>()..add(LoadThemeEvent()),
        ),
      ],
      child: MyApp(onBoarding: onBoarding),
    ),
  );
}
