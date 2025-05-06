import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/routes/public_routes_name.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';

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
                  ElevatedButton(
                    onPressed: () {
                      // Reject action (Go back to the previous page or close the app)
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Reject button color
                    ),
                    child: Text(
                      Locales.string(
                        context,
                        'terms_and_conditions_page_decline_button',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Accept action (Navigate to the next page or accept the terms)
                      Navigator.pushReplacementNamed(
                        context,
                        PublicRoutesName.mobileVerificationPage,
                        arguments: {'routeName': PublicRoutesName.registerPage},
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Accept button color
                    ),
                    child: Text(
                      Locales.string(
                        context,
                        'terms_and_conditions_page_accept_button',
                      ),
                    ),
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
