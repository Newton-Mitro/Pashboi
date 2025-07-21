import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: PageContainer(
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

                            Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'FontSam', // Replace with your font
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            AppTextInput(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: context.theme.colorScheme.onSurface,
                              ),
                              controller: currentPasswordController,
                              label: 'Current Password',
                              obscureText: true,
                            ),
                            AppTextInput(
                              controller: newPasswordController,
                              prefixIcon: Icon(
                                Icons.lock,
                                color: context.theme.colorScheme.onSurface,
                              ),
                              label: 'New Password',
                              obscureText: true,
                            ),
                            PasswordStrengthIndicatorPlus(
                              textController: newPasswordController,
                              hideRules: true,
                            ),
                            AppTextInput(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: context.theme.colorScheme.onSurface,
                              ),
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
              backgroundColor: context.theme.colorScheme.primary,
              progressColor: context.theme.colorScheme.secondary,
              foregroundColor: context.theme.colorScheme.onPrimary,
              label: 'Hold & Press to Submit',
              onSubmit: () {
                // Add your password change logic here
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
