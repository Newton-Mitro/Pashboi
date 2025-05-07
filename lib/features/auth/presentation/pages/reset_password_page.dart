import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, 'reset_password_page_title')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(width: 150),
                const SizedBox(height: 36),
                AppTextInput(
                  controller: _emailController,
                  label: Locales.string(
                    context,
                    'reset_password_page_email_label',
                  ),
                  errorText: null,
                  prefixIcon: Icon(
                    Icons.email,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                AppTextInput(
                  controller: _passwordController,
                  label: Locales.string(
                    context,
                    'reset_password_page_password_label',
                  ),
                  errorText: null,
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                AppTextInput(
                  controller: _confirmPasswordController,
                  label: Locales.string(
                    context,
                    'reset_password_page_confirm_password_label',
                  ),
                  errorText: null,
                  obscureText: true,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.lock_reset,
                    color: context.theme.colorScheme.onPrimary,
                  ),
                  label: Text(
                    Locales.string(
                      context,
                      'reset_password_page_reset_password_button',
                    ),
                  ),
                  onPressed: () {
                    // TODO: Add reset logic
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
