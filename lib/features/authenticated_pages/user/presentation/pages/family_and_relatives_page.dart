import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class FamilyAndRelativesPage extends StatefulWidget {
  const FamilyAndRelativesPage({super.key});

  @override
  State<FamilyAndRelativesPage> createState() => _FamilyAndRelativesPageState();
}

class _FamilyAndRelativesPageState extends State<FamilyAndRelativesPage> {
  final List<Map<String, dynamic>> accountInfo = [
    {
      "gender": "M",
      "name": "Md Israfil Hossain",
      "relation": "Father",
      "status": "Approved",
    },
    {
      "gender": "F",
      "name": "Sharmin Akter",
      "relation": "Mother",
      "status": "Approved",
    },
    {
      "gender": "M",
      "name": "Md Mahmudul Hasan",
      "relation": "Brother",
      "status": "Pending",
    },
    {
      "gender": "F",
      "name": "Nusrat Jahan",
      "relation": "Sister",
      "status": "Approved",
    },
    {
      "gender": "M",
      "name": "Raihan Kabir",
      "relation": "Uncle",
      "status": "Approved",
    },
    {
      "gender": "F",
      "name": "Sumaiya Rahman",
      "relation": "Aunt",
      "status": "Approved",
    },
    {
      "gender": "F",
      "name": "Tania Sultana",
      "relation": "Cousin",
      "status": "Pending",
    },
  ];

  void onTap() {
    // TODO: Implement tap functionality
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(title: Text('Family and Relatives')),
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
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 30,
                        ),
                        itemCount: accountInfo.length,
                        itemBuilder: (context, index) {
                          final info = accountInfo[index];
                          final isMale = info['gender'] == 'M';
                          final icon =
                              isMale
                                  ? FontAwesomeIcons.mars
                                  : FontAwesomeIcons.venus;
                          final requestStatus = info['status'];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: onTap,
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
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                context
                                                    .theme
                                                    .colorScheme
                                                    .primary,
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomLeft: Radius.circular(
                                                    4,
                                                  ),
                                                ),
                                          ),
                                          child: SizedBox.expand(
                                            child: Center(
                                              child: Icon(
                                                icon,
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
                                      ),
                                      Expanded(
                                        flex: 9,
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
                                                info['name'],
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      theme
                                                          .colorScheme
                                                          .onSurface,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                info['relation'],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color:
                                                      theme
                                                          .colorScheme
                                                          .onSurface,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 0,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      requestStatus ==
                                                              "Approved"
                                                          ? Colors.green
                                                          : Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  requestStatus,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Lexend',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color:
                                                        requestStatus ==
                                                                "Approved"
                                                            ? context
                                                                .theme
                                                                .colorScheme
                                                                .onTertiary
                                                            : context
                                                                .theme
                                                                .colorScheme
                                                                .onSecondary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                AppPrimaryButton(
                  iconBefore: const Icon(Icons.person_add),
                  label: "Add Family or Relative",
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AuthRoutesName.addFamilyMemberPage,
                    );
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
