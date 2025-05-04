import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/app_logo.dart';
import 'package:pashboi/core/widgets/language_selector/language_selector.dart';
import 'package:pashboi/core/widgets/theme_switcher/theme_switcher.dart';
import 'package:pashboi/pages/public/terms_and_condition_page/views/terms_and_conditions_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LanguageSelector(), ThemeSwitcher()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppLogo(width: 200, height: 200),
                Text(
                  Locales.string(context, 'welcome'),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Text before Login Button
                _buildInfoText(
                  context,
                  Locales.string(context, 'login_instruction'),
                ),
                const SizedBox(height: 12),

                // Login Button
                _buildButton(
                  context,
                  label: Locales.string(context, 'login'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.loginPage);
                  },
                ),
                const SizedBox(height: 20),

                // Text before Register Button
                _buildInfoText(
                  context,
                  Locales.string(context, 'register_instruction'),
                ),
                const SizedBox(height: 12),

                // Register Button
                _buildButton(
                  context,
                  label: Locales.string(context, 'register'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Text before Product & Service Button
                _buildInfoText(
                  context,
                  Locales.string(context, 'product_and_service_instruction'),
                ),
                const SizedBox(height: 12),

                // Product & Service Button
                _buildButton(
                  context,
                  label: Locales.string(context, 'product_and_service'),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.publicHomePage);
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 44, // made smaller (was 56)
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ), // also slightly tighter curve
            side: BorderSide(color: context.theme.colorScheme.secondary),
          ),
          backgroundColor: context.theme.colorScheme.primary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          textStyle: const TextStyle(
            fontSize: 16, // slightly smaller text
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget _buildInfoText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: context.theme.colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }
}
