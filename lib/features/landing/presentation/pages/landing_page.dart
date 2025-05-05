import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/language_selector/language_selector.dart';
import 'package:pashboi/shared/widgets/theme_switcher/theme_switcher.dart';
import 'package:pashboi/my_app.dart';
import 'package:pashboi/features/terms_and_condition/presentation/pages/terms_and_conditions_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with RouteAware {
  final GlobalKey<AppLogoState> _logoKey = GlobalKey<AppLogoState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _logoKey.currentState?.replayAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [LanguageSelector(), ThemeSwitcher()],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppLogo(key: _logoKey, width: 150, height: 150),
              Text(
                Locales.string(context, 'landing_page_welcome_text'),
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: context.theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildInfoText(
                context,
                Locales.string(context, 'landing_page_login_instruction'),
              ),
              const SizedBox(height: 12),
              _buildButton(
                context,
                label: Locales.string(context, 'landing_page_login_button'),
                onPressed: () {
                  Navigator.pushNamed(context, PublicRoutesName.loginPage);
                },
              ),
              const SizedBox(height: 20),
              _buildInfoText(
                context,
                Locales.string(
                  context,
                  'landing_page_create_account_instruction',
                ),
              ),
              const SizedBox(height: 12),
              _buildButton(
                context,
                label: Locales.string(
                  context,
                  'landing_page_create_account_button',
                ),
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
              _buildInfoText(
                context,
                Locales.string(
                  context,
                  'landing_page_product_and_service_instruction',
                ),
              ),
              const SizedBox(height: 12),
              _buildButton(
                context,
                label: Locales.string(
                  context,
                  'landing_page_product_and_service_button',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, PublicRoutesName.publicHomePage);
                },
              ),
              const SizedBox(height: 32),
            ],
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
      height: 44,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: context.theme.colorScheme.secondary),
          ),
          backgroundColor: context.theme.colorScheme.primary,
          foregroundColor: context.theme.colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
