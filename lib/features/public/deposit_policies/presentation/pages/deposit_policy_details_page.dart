import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/public/deposit_policies/domain/enities/deposit_policy_entity.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DepositPolicyDetailsPage extends StatelessWidget {
  final DepositPolicyEntity depositPolicy;

  const DepositPolicyDetailsPage({super.key, required this.depositPolicy});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        depositPolicy.attachmentUrl; // optional: add this field in entity
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
                    height: 200,
                    width: double.infinity,
                    child: FaIcon(
                      FontAwesomeIcons.piggyBank,
                      size: 150,
                      color: context.theme.colorScheme.primary,
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
              Text(
                depositPolicy.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Published on: ${DateTime.now().toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Posted by: Dhaka Credit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Text(
                depositPolicy.longDescription,
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
