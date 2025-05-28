import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/ui/new_widget/small_card.dart';

class FamilyAndRelatives extends StatefulWidget {
  const FamilyAndRelatives({super.key});

  @override
  State<FamilyAndRelatives> createState() => _FamilyAndRelativesState();
}

class _FamilyAndRelativesState extends State<FamilyAndRelatives> {
  final List<Map<String, dynamic>> accountInfo = [
    {
      "gender": "male",
      "name": "Md Israfil",
      "accountNo": "T-1234567890",
      "status": "Approved",
    },
    {
      "gender": "male",
      "name": "Md Mahmudul Hasan",
      "accountNo": "T-0987654321",
      "status": "Pending",
    },
    {
      "gender": "female",
      "name": "Md Shakib Al Hasan",
      "accountNo": "T-1122334455",
      "status": "Approved",
    },
    {
      "gender": "female",
      "name": "Md Sakib Al Hasan",
      "accountNo": "T-5566778899",
      "status": "Approved",
    },
    {
      "gender": "male",
      "name": "Md Mahmudul Hasan",
      "accountNo": "T-0987654321",
      "status": "Approved",
    },
    {
      "gender": "female",
      "name": "Md Shakib Al Hasan",
      "accountNo": "T-1122334455",
      "status": "Approved",
    },
    {
      "gender": "female",
      "name": "Md Sakib Al Hasan",
      "accountNo": "T-5566778899",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Family and Relatives',
              style: TextStyle(
                color: context.theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.onSurface,
            ),
          ],
        ),
      ),
      body: AppBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Render account cards
                Column(
                  children: [
                    if (accountInfo.isEmpty)
                      Center(
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
                    else
                      ...accountInfo.map((account) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: SmallCard(
                            gender: account['gender'],
                            titleText: account['name'],
                            subtitleText: account['accountNo'],
                            requestStatus: account['status'],
                          ),
                        );
                      }),
                  ],
                ),
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
                    const SizedBox(height: 16),

                    AppPrimaryButton(
                      iconBefore: Icon(Icons.person_add),
                      label: "Add Person",
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
