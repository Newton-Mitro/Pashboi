import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/injection.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/app_logo.dart';
import 'package:pashboi/core/widgets/app_text_input.dart';
import 'package:pashboi/core/widgets/network_error_dialog.dart';
import 'package:pashboi/pages/public/register_page/bloc/registration_screen_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
      create: (context) => sl<RegistrationScreenBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.appLocalizations.register,
            style: TextStyle(color: context.theme.colorScheme.onPrimary),
          ),
        ),
        body: BlocListener<RegistrationScreenBloc, RegistrationState>(
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
              Navigator.pushReplacementNamed(context, RoutesName.homePage);
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: BlocBuilder<RegistrationScreenBloc, RegistrationState>(
                  builder: (context, state) {
                    return Column(
                      spacing: 10,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppLogo(width: 150, height: 150),
                        AppTextInput(
                          controller: nameController,
                          label: context.appLocalizations.lbl_name,
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
                          label: context.appLocalizations.lbl_email,
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
                          label: context.appLocalizations.lbl_password,
                          errorText:
                              state is RegistrationValidationErrorState
                                  ? state.errors['password']?.isNotEmpty == true
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
                          label: context.appLocalizations.lbl_confirm_password,
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
                        BlocBuilder<RegistrationScreenBloc, RegistrationState>(
                          builder: (context, state) {
                            if (state is RegistrationLoadingState) {
                              return CircularProgressIndicator();
                            }
                            return ElevatedButton(
                              onPressed: () {
                                context.read<RegistrationScreenBloc>().add(
                                  RegisterEvent(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.1,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: context.theme.colorScheme.secondary,
                                  ),
                                ),
                                backgroundColor:
                                    context.theme.colorScheme.primary,
                                foregroundColor:
                                    context.theme.colorScheme.onSecondary,
                              ),
                              child: Text(
                                context.appLocalizations.createAccount,
                                style: TextStyle(
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.appLocalizations.alreadyHaveAccount,
                              style: TextStyle(
                                color: context.theme.colorScheme.onSurface,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesName.loginPage,
                                );
                              },
                              child: Text(
                                context.appLocalizations.login,
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
    );
  }
}
