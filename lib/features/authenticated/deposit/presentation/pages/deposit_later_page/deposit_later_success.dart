import 'package:flutter/material.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class DepositLaterSuccessPage extends StatelessWidget {
  final String successMessage;

  const DepositLaterSuccessPage({super.key, required this.successMessage});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Deposit Later Success")),
      body: PageContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🎯 Circle success icon
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primary.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(24),
              child: Icon(
                Icons.check_circle_rounded,
                size: 80,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Main title
            Text(
              "Transaction Successful!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // 📝 Subtitle / Custom message
            Text(
              successMessage,
              style: TextStyle(fontSize: 16, color: colorScheme.onSurface),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // 🚀 CTA Button
            AppPrimaryButton(
              label: "Back To Home",
              // label: Locales.string(context, 'login_page_login_button'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconBefore: Icon(
                Icons.home,
                color: context.theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
