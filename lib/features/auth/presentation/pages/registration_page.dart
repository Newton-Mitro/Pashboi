import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/network_error_dialog.dart';
import 'package:pashboi/features/auth/presentation/bloc/registration_page_bloc/registration_page_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(
    text: '',
  );
  final TextEditingController confirmPasswordController = TextEditingController(
    text: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegistrationPageBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Locales.string(context, 'register_page_title'),
            style: TextStyle(color: context.theme.colorScheme.onPrimary),
          ),
        ),
        body: BlocListener<RegistrationPageBloc, RegistrationPageState>(
          listener: (context, state) {
            if (state is RegistrationErrorState) {
              if (state.message == "No internet connection") {
                NetworkErrorDialog.show(context);
              } else {
                final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'On Snap!',
                    message: state.message,

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.failure,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            }

            if (state is RegistrationSuccessState) {
              Navigator.pushReplacementNamed(
                context,
                PublicRoutesName.homePage,
              );
            }
          },
          child: AppBackground(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: BlocBuilder<
                    RegistrationPageBloc,
                    RegistrationPageState
                  >(
                    builder: (context, state) {
                      return Column(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppLogo(width: 150),
                          AppTextInput(
                            controller: nameController,
                            label: Locales.string(
                              context,
                              'register_page_name_label',
                            ),
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['name']?.isNotEmpty == true
                                        ? state.errors['name']![0]
                                        : null
                                    : null,
                            prefixIcon: Icon(
                              Icons.person,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          AppTextInput(
                            controller: emailController,
                            label: Locales.string(
                              context,
                              'register_page_email_label',
                            ),
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['email']?.isNotEmpty == true
                                        ? state.errors['email']![0]
                                        : null
                                    : null,
                            prefixIcon: Icon(
                              Icons.email,
                              color: context.theme.colorScheme.onSurface,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          AppTextInput(
                            controller: passwordController,
                            label: Locales.string(
                              context,
                              'register_page_password_label',
                            ),
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state.errors['password']?.isNotEmpty ==
                                            true
                                        ? state.errors['password']![0]
                                        : null
                                    : null,
                            obscureText: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          AppTextInput(
                            controller: confirmPasswordController,
                            label: Locales.string(
                              context,
                              'register_page_confirm_password_label',
                            ),
                            errorText:
                                state is RegistrationValidationErrorState
                                    ? state
                                                .errors['confirm_password']
                                                ?.isNotEmpty ==
                                            true
                                        ? state.errors['confirm_password']![0]
                                        : null
                                    : null,
                            obscureText: true,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: context.theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<
                            RegistrationPageBloc,
                            RegistrationPageState
                          >(
                            builder: (context, state) {
                              if (state is RegistrationLoadingState) {
                                return CircularProgressIndicator();
                              }
                              return AppPrimaryButton(
                                label: Locales.string(
                                  context,
                                  'register_page_create_account_button',
                                ),
                                iconBefore: Icon(
                                  Icons.person_add,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                                onPressed: () {
                                  context.read<RegistrationPageBloc>().add(
                                    RegisterEvent(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      confirmPassword:
                                          confirmPasswordController.text,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                Locales.string(
                                  context,
                                  'register_page_already_have_account_text',
                                ),
                                style: TextStyle(
                                  color: context.theme.colorScheme.onSurface,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    PublicRoutesName.loginPage,
                                  );
                                },
                                child: Text(
                                  Locales.string(
                                    context,
                                    'register_page_login_button',
                                  ),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
