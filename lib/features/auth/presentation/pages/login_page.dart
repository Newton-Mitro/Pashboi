import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/network_error_dialog.dart';
import 'package:pashboi/features/terms_and_condition/presentation/pages/terms_and_conditions_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(Locales.string(context, 'login_page_title')),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushNamed(context, PublicRoutesName.homePage);
            }

            if (state is AuthError) {
              if (state.message == "No internet connection") {
                NetworkErrorDialog.show(context);
              } else {
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Oops!',
                    message: state.message,
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            }
          },
          child: AppBackground(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 36),
              child: Column(
                spacing: 10,
                children: [
                  const AppLogo(width: 150),
                  const SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          AppTextInput(
                            controller: usernameController,
                            label: Locales.string(
                              context,
                              'login_page_user_name_label',
                            ),
                            errorText:
                                state is AuthValidationErrorState
                                    ? state.errors['email']?.isNotEmpty == true
                                        ? state.errors['email']
                                        : null
                                    : null,
                            prefixIcon: Icon(
                              Icons.person,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 12),
                          AppTextInput(
                            controller: passwordController,
                            label: Locales.string(
                              context,
                              'login_page_password_label',
                            ),
                            obscureText: true,
                            errorText:
                                state is AuthValidationErrorState
                                    ? state.errors['password']?.isNotEmpty ==
                                            true
                                        ? state.errors['password']
                                        : null
                                    : null,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  PublicRoutesName.mobileVerificationPage,
                                  arguments: {
                                    'routeName':
                                        PublicRoutesName.resetPasswordPage,
                                  },
                                );
                              },
                              child: Text(
                                Locales.string(
                                  context,
                                  'login_page_forgot_password_button',
                                ),
                                style: TextStyle(
                                  color: context.theme.colorScheme.onSurface,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          if (state is AuthLoading)
                            const CircularProgressIndicator()
                          else
                            AppPrimaryButton(
                              label: Locales.string(
                                context,
                                'login_page_login_button',
                              ),
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  LoginRequested(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                  ),
                                );
                              },
                              iconBefore: Icon(
                                Icons.login,
                                color: context.theme.colorScheme.onPrimary,
                              ),
                            ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Locales.string(
                                  context,
                                  'login_page_dont_have_account_text',
                                ),
                                style: TextStyle(
                                  color: context.theme.colorScheme.onSurface,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const TermsAndConditionsPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  Locales.string(
                                    context,
                                    'login_page_create_account_button',
                                  ),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
