import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/features/public/loan_policies/domain/entites/loan_policy_entity.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LoanPolicyDetailsPage extends StatelessWidget {
  final LoanPolicyEntity loanPolicy;

  const LoanPolicyDetailsPage({super.key, required this.loanPolicy});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl =
        loanPolicy.attachmentUrl; // optional: add this field in entity
    final bool showIcon = imageUrl == null || imageUrl.isEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Deposit Policy Details'), elevation: 0),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon
                  ? Container(
                    alignment: Alignment.center,
                    height: 150,
                    width: double.infinity,
                    child: FaIcon(
                      FontAwesomeIcons.sackDollar,
                      size: 100,
                      color: context.theme.colorScheme.onPrimary,
                    ),
                  )
                  : Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              const SizedBox(height: 16),

              Html(data: loanPolicy.longDescription),
              // HtmlContentWebView(htmlContent: depositPolicy.longDescription),
            ],
          ),
        ),
      ),
    );
  }
}
