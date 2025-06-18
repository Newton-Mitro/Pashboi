import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DependentsPage extends StatefulWidget {
  const DependentsPage({super.key});

  @override
  State<DependentsPage> createState() => _DependentsPageState();
}

class _DependentsPageState extends State<DependentsPage> {
  final List<Map<String, dynamic>> accountInfo = [
    {"id": 1, "name": "Md Israfil"},
    {"id": 2, "name": "Md Mahmudul Hasan"},
    {"id": 3, "name": "John Doe"},
    {"id": 4, "name": "Jane Doe"},
    {"id": 5, "name": "Raihan Kabir"},
    {"id": 6, "name": "Sumaiya Rahman"},
    {"id": 7, "name": "Tania Sultana"},
    {"id": 8, "name": "Nusrat Jahan"},
    {"id": 9, "name": "Sharmin Akter"},
    {"id": 10, "name": "Md Israfil Hossain"},
    {"id": 11, "name": "Md Mahmudul Hasan"},
    {"id": 12, "name": "John Doe"},
  ];

  final Map<int, GlobalKey> _dismissKeys = {};

  @override
  void initState() {
    super.initState();
    for (var item in accountInfo) {
      _dismissKeys[item['id']] = GlobalKey();
    }
  }

  void _handleTap(Map<String, dynamic> beneficiary) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Selected: ${beneficiary["name"]}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dependents')),
      body: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  accountInfo.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.boxOpen,
                              size: 60,
                              color: context.theme.colorScheme.onSurface
                                  .withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'You don’t have any dependents yet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: context.theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
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
                                    // Left Icon
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
                                            FontAwesomeIcons.children,
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

                                    // Info
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
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Static Delete Icon
                                    Expanded(
                                      flex: 2,
                                      child: Icon(
                                        Icons.navigate_next,
                                        color:
                                            context.theme.colorScheme.onSurface,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Click to add a dependent!',
                    style: TextStyle(
                      fontSize: 12,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AppPrimaryButton(
                    iconBefore: const Icon(Icons.person_add),
                    horizontalPadding: 6,
                    label: "Add Operating Account",
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AuthRoutesName.addOperatingAccountPage,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
