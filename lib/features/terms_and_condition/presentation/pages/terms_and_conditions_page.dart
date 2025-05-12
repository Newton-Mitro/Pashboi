import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/buttons/app_error_button.dart';
import 'package:pashboi/shared/widgets/buttons/app_warning_button.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, 'terms_and_conditions_page_title')),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Display the terms and conditions content inside a scrollable view
                HtmlWidget(
                  '''
                <h2>Terms and Conditions</h2>

                <p>Welcome to <strong>Pashboi</strong>! By using our app, you agree to the following terms and conditions:</p>

                <h3>1. Use of Service</h3>
                <p>You agree to use the service only for lawful purposes and in a way that does not infringe the rights of others.</p>

                <h3>2. Privacy Policy</h3>
                <p>Your data will be handled in accordance with our <a href="https://example.com/privacy-policy">Privacy Policy</a>.</p>

                <h3>3. Account Security</h3>
                <p>You are responsible for maintaining the confidentiality of your account and password.</p>

                <h3>4. Intellectual Property</h3>
                <p>All content, trademarks, and data on this app are the property of <strong>Pashboi</strong> and protected by copyright laws.</p>

                <h3>5. Termination</h3>
                <p>We reserve the right to terminate your account if you violate any of the terms stated here.</p>

                <p>For more information, contact us at <a href="mailto:support@example.com">support@example.com</a>.</p>

                <p><em>Last updated: May 7, 2025</em></p>
                ''',
                  customStylesBuilder: (element) {
                    if (element.classes.contains('foo')) {
                      return {'color': 'red'};
                    }
                    return null;
                  },
                  renderMode: RenderMode.column,
                  textStyle: TextStyle(fontSize: 14),
                ),
                // Add more terms here
                const SizedBox(height: 20), // Space before buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppErrorButton(
                      label: Locales.string(
                        context,
                        'terms_and_conditions_page_decline_button',
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      iconBefore: Icon(Icons.close, color: Colors.red),
                      horizontalPadding: 0,
                    ),

                    AppWarningButton(
                      label: Locales.string(
                        context,
                        'terms_and_conditions_page_accept_button',
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          PublicRoutesName.mobileVerificationPage,
                          arguments: {
                            'routeName': PublicRoutesName.registerPage,
                          },
                        );
                      },
                      iconBefore: Icon(Icons.check, color: Colors.green),
                      horizontalPadding: 0,
                    ),
                  ],
                ),
                const SizedBox(height: 50), // Space before buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
