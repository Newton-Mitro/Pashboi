import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center the logo
              Center(child: AppLogo(width: 150)),
              const SizedBox(height: 20),
              const Text(
                'Terms and Conditions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Display the terms and conditions content inside a scrollable view
              const Text(
                '1. You must agree to the terms and conditions to use our app.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '2. We collect certain personal information to improve your experience.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '3. We are not responsible for any damages or losses that occur while using the app.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '4. We may update the terms and conditions from time to time.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '5. You can contact us for more information regarding the terms.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '6. You can contact us for more information regarding the terms.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '7. You can contact us for more information regarding the terms.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Text(
                '8. You can contact us for more information regarding the terms.',
                style: TextStyle(fontSize: 16),
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
                        arguments: {'routeName': PublicRoutesName.registerPage},
                      );
                    },
                    iconBefore: Icon(Icons.check, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 50), // Space before buttons
            ],
          ),
        ),
      ),
    );
  }
}
