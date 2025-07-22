import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/profile/presentation/change_password/bloc/change_password_bloc.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/network_error_dialog.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/shared/widgets/progress_submit_button/progress_submit_button.dart';
import 'package:password_strength_indicator_plus/password_strength_indicator_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isValidInput() {
    return currentPasswordController.text.trim().isNotEmpty &&
        newPasswordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;
  }

  void _submit() {
    if (!_isValidInput()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter all fields")));
      return;
    }

    context.read<ChangePasswordBloc>().add(
      ChangePasswordSubmitted(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordError) {
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
          if (state is ChangePasswordSuccess) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.message),
            //     backgroundColor: Colors.green,
            //   ),
            // );
            final snackBar = SnackBar(
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: context.theme.colorScheme.primary,
              content: AwesomeSnackbarContent(
                title: 'Success',
                message: state.message,
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            // Navigator.pop(context);
          }
        },
        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
          builder: (context, state) {
            return PageContainer(
              child: Column(
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: IntrinsicHeight(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 16,
                                children: [
                                  Icon(FontAwesomeIcons.key, size: 40),
                                  AppTextInput(
                                    label: 'Current Password',
                                    controller: currentPasswordController,
                                    errorText:
                                        state is ChangePasswordValidationError
                                            ? state
                                                        .errors['currentPassword']
                                                        ?.isNotEmpty ==
                                                    true
                                                ? state
                                                    .errors['currentPassword']
                                                : null
                                            : null,
                                    obscureText: true,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color:
                                          context.theme.colorScheme.onSurface,
                                    ),
                                  ),

                                  AppTextInput(
                                    controller: newPasswordController,
                                    errorText:
                                        state is ChangePasswordValidationError
                                            ? state
                                                        .errors['newPassword']
                                                        ?.isNotEmpty ==
                                                    true
                                                ? state.errors['newPassword']
                                                : null
                                            : null,
                                    obscureText: true,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color:
                                          context.theme.colorScheme.onSurface,
                                    ),
                                    label: 'New Password',
                                  ),
                                  PasswordStrengthIndicatorPlus(
                                    textController: newPasswordController,
                                    hideRules: true,
                                  ),
                                  AppTextInput(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color:
                                          context.theme.colorScheme.onSurface,
                                    ),
                                    errorText:
                                        state is ChangePasswordValidationError
                                            ? state
                                                        .errors['confirmPassword']
                                                        ?.isNotEmpty ==
                                                    true
                                                ? state
                                                    .errors['confirmPassword']
                                                : null
                                            : null,
                                    controller: confirmPasswordController,
                                    label: 'Confirm New Password',
                                    obscureText: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  ProgressSubmitButton(
                    width: width - 10,
                    height: 100,
                    enabled: state is ChangePasswordLoading ? false : true,
                    backgroundColor: context.theme.colorScheme.primary,
                    progressColor: context.theme.colorScheme.secondary,
                    foregroundColor: context.theme.colorScheme.onPrimary,
                    label: 'Hold & Press to Submit',
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
