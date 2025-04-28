import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/auth_module.dart';
import 'package:pashboi/features/home/presentation/notifier/notifiers.dart';
import 'package:pashboi/features/home/presentation/widgets/home_screen_body.dart';
import 'package:pashboi/features/user/data/models/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final localStorage = sl<LocalStorage>();
    final authUser = await localStorage.getString(Constants.authUserKey);
    if (authUser != null) {
      authUserNotifier.value = UserModel.fromJson(jsonDecode(authUser));
    }

    final accessToken = await localStorage.getString(Constants.accessTokenKey);
    accessTokenNotifier.value = accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, RoutesName.root);
          }
        },
        child: HomeScreenBody(),
      ),
    );
  }
}
