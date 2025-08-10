import 'package:flutter/material.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WithdrawQrSuccessPage extends StatelessWidget {
  final String successMessage;

  const WithdrawQrSuccessPage({super.key, required this.successMessage});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text("Generated Success")),
      body: PageContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 📷 QR Code image section
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant, width: 1),
              ),
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: successMessage,
                version: QrVersions.auto,
                size: 250.0,
                backgroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Main title
            Text(
              "Withdrawal QR Generated!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // 🚀 CTA Button
            AppPrimaryButton(
              label: "Back To Home",
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
