import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/shared/widgets/language_selector/bloc/language_bloc.dart';
import 'package:pashboi/shared/widgets/theme_switcher/bloc/theme_bloc.dart';
import 'package:pashboi/injection.dart';
import 'package:pashboi/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Locales.init(['en', 'bn']);
  await setupDependencies(); // Register dependencies
  final localStorage = sl<LocalStorage>();

  final bool onBoarding =
      await localStorage.getBool(StorageKey.keyOnboarding) ?? true;

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
