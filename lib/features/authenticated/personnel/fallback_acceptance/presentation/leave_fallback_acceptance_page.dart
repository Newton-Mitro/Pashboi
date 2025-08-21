import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/app_icon_card.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveFallbackAcceptancePage extends StatefulWidget {
  const LeaveFallbackAcceptancePage({super.key});

  @override
  State<LeaveFallbackAcceptancePage> createState() =>
      _LeaveFallbackAcceptancePageState();
}

class _LeaveFallbackAcceptancePageState
    extends State<LeaveFallbackAcceptancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fallback Acceptance")),
      body: PageContainer(child: SingleChildScrollView(child: _buildForm())),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconCard(
            leftIcon: FontAwesomeIcons.mugHot,
            rightIcon: FontAwesomeIcons.chevronRight,
            boarderColor: context.theme.colorScheme.primary,
            cardBody: Column(
              children: [
                Text("Md Israfil"),
                Text("From: 2023-10-01"),
                Text("To: 2023-10-05"),
              ],
            ),
            onTap:
                () => {
                  Navigator.pushNamed(
                    context,
                    AuthRoutesName.fallbackAcceptedPage,
                  ),
                },
          ),
        ],
      ),
    );
  }
}
