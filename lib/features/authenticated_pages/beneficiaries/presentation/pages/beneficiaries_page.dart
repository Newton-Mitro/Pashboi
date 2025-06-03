import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class BeneficiariesPage extends StatefulWidget {
  const BeneficiariesPage({super.key});

  @override
  State<BeneficiariesPage> createState() => _BeneficiariesPageState();
}

class _BeneficiariesPageState extends State<BeneficiariesPage> {
  final List<Map<String, dynamic>> accountInfo = [
    {"id": 1, "name": "Md Israfil", "accountNo": "T-1234567890"},
    {"id": 2, "name": "Md Mahmudul Hasan", "accountNo": "T-0987654321"},
    {"id": 3, "name": "John Doe", "accountNo": "T-1122334455"},
    {"id": 4, "name": "Jane Smith", "accountNo": "T-5566778899"},
    {"id": 5, "name": "Ashlley Gray", "accountNo": "T-1122334455"},
    {"id": 6, "name": "James Brown", "accountNo": "T-5566778899"},
    {"id": 7, "name": "Emily Johnson", "accountNo": "T-1234567890"},
    {"id": 8, "name": "Michael Davis", "accountNo": "T-0987654321"},
    {"id": 9, "name": "Sarah Wilson", "accountNo": "T-1122334455"},
    {"id": 10, "name": "David Martinez", "accountNo": "T-5566778899"},
  ];

  void _handleTap(Map<String, dynamic> beneficiary) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Selected: ${beneficiary["name"]}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Beneficiaries')),
      body: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  accountInfo.isEmpty
                      ? Center(
                        child: Text(
                          'You don’t have any family or relative accounts added',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: context.theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                      : ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: accountInfo.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final beneficiary = accountInfo[index];
                          return InkWell(
                            onTap: () => _handleTap(beneficiary),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.surface,
                                border: Border.all(
                                  color: context.theme.colorScheme.primary,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  children: [
                                    // Left Icon Box
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              context.theme.colorScheme.primary,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            FontAwesomeIcons.personCirclePlus,
                                            size: 30,
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .onPrimary,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Info Section
                                    Expanded(
                                      flex: 7,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              beneficiary["name"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "${beneficiary["accountNo"]}",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Delete Button
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color:
                                              context
                                                  .theme
                                                  .colorScheme
                                                  .onSurface,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            accountInfo.removeAt(index);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Click to add a family member or a relative!',
                  style: TextStyle(
                    fontSize: 12,
                    color: context.theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                AppPrimaryButton(
                  iconBefore: const Icon(Icons.person_add),
                  horizontalPadding: 6,
                  label: "Add Beneficiary",
                  onPressed: () {
                    // Add new person logic here
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
