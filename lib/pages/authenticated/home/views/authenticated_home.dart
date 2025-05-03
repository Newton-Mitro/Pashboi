import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/constants/constants.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';
import 'package:pashboi/pages/authenticated/home/bloc/auth_bloc.dart';
import 'package:pashboi/pages/authenticated/home/notifier/notifiers.dart';
import 'package:pashboi/pages/authenticated/home/widgets/home_screen_body.dart';

class AuthenticatedHome extends StatefulWidget {
  const AuthenticatedHome({super.key});

  @override
  State<AuthenticatedHome> createState() => _AuthenticatedHomeState();
}

class _AuthenticatedHomeState extends State<AuthenticatedHome> {
  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final localStorage = sl<LocalStorage>();
    final authUser = await localStorage.getString(Constants.keyAuthUser);
    if (authUser != null) {
      authUserNotifier.value = UserModel.fromJson(jsonDecode(authUser));
    }

    final accessToken = await localStorage.getString(Constants.keyAccessToken);
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
