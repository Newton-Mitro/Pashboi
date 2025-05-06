import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/main.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/language_selector/language_selector.dart';
import 'package:pashboi/shared/widgets/theme_switcher/theme_switcher.dart';
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
        actions: [ThemeSwitcher(), LanguageSelector()],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Center content at the top
              Column(
                children: [
                  AppLogo(key: _logoKey, width: 150, height: 150),
                  const SizedBox(height: 36),
                  Text(
                    Locales.string(context, 'landing_page_welcome_text'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Tooltip(
                        waitDuration: Duration(microseconds: 1),
                        message: Locales.string(
                          context,
                          'landing_page_login_instruction',
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            // Do something
                          },
                          child: Icon(Icons.info),
                        ),
                      ),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      Tooltip(
                        waitDuration: Duration(microseconds: 1),
                        message: Locales.string(
                          context,
                          'landing_page_create_account_instruction',
                        ),
                        child: GestureDetector(
                          onLongPress: () {
                            // Do something
                          },
                          child: Icon(Icons.info),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 36,
                        child: FilledButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                color: context.theme.colorScheme.secondary,
                              ),
                            ),
                            backgroundColor:
                                context.theme.colorScheme.secondary,
                            foregroundColor:
                                context.theme.colorScheme.onSecondary,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const TermsAndConditionsPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ), // Adjust as needed
                            child: Text(
                              Locales.string(
                                context,
                                'landing_page_create_account_button',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              // Spacer to push Product and Service to the bottom
              Spacer(),
              // Product and Service at the bottom
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildInfoText(
                    context,
                    Locales.string(
                      context,
                      'landing_page_product_and_service_instruction',
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 36,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          PublicRoutesName.publicHomePage,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                        ), // Adjust as needed
                        child: Text(
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.theme.colorScheme.onSurface,
                            decoration: TextDecoration.underline,
                          ),
                          Locales.string(
                            context,
                            'landing_page_product_and_service_button',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 36,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: context.theme.colorScheme.secondary),
              ),
              backgroundColor: context.theme.colorScheme.primary,
              foregroundColor: context.theme.colorScheme.onPrimary,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ), // Adjust as needed
              child: Text(label),
            ),
          ),
        ),
      ],
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
