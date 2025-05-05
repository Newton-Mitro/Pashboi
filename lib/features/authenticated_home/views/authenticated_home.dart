import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/constants/storage_key.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/local_storage.dart';
import 'package:pashboi/features/auth/data/models/user_model.dart';
import 'package:pashboi/features/authenticated_home/bloc/auth_bloc.dart';
import 'package:pashboi/features/authenticated_home/notifier/notifiers.dart';
import 'package:pashboi/features/authenticated_home/widgets/home_screen_body.dart';

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
    final authUser = await localStorage.getString(StorageKey.keyAuthUser);
    if (authUser != null) {
      authUserNotifier.value = UserModel.fromJson(jsonDecode(authUser));
    }

    final accessToken = await localStorage.getString(StorageKey.keyAccessToken);
    accessTokenNotifier.value = accessToken;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => sl<AuthBloc>())],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.pushReplacementNamed(context, PublicRoutesName.root);
          }
        },
        child: HomeScreenBody(),
      ),
    );
  }
}
