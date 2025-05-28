import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/ui/new_widget/small_card.dart';

class FamilyAndRelatives extends StatefulWidget {
  const FamilyAndRelatives({super.key});

  @override
  State<FamilyAndRelatives> createState() => _FamilyAndRelativesState();
}

class _FamilyAndRelativesState extends State<FamilyAndRelatives> {
  final List<Map<String, dynamic>> accountInfo = [
    {"gender": "male", "name": "Md Israfil", "accountNo": "T-1234567890"},
    {
      "gender": "male",
      "name": "Md Mahmudul Hasan",
      "accountNo": "T-0987654321",
    },
    {
      "gender": "female",
      "name": "Md Shakib Al Hasan",
      "accountNo": "T-1122334455",
    },
    {
      "gender": "female",
      "name": "Md Sakib Al Hasan",
      "accountNo": "T-5566778899",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Family and Relatives',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(FontAwesomeIcons.house, size: 20, color: Colors.white),
          ],
        ),
      ),
      body: AppBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Render account cards
              Column(
                children: [
                  if (accountInfo.isEmpty)
                    const Center(
                      child: Text(
                        'You don’t have any family or relative accounts added',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  else
                    ...accountInfo.map((account) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SmallCard(
                          icon: Icon(
                            account['gender'] == 'male'
                                ? Icons.man
                                : Icons.woman,
                            size: 30,
                            color: Colors.white,
                          ),
                          menuName: account['name'],
                          menuDescription: account['accountNo'],
                          buttonText: "Approved",
                        ),
                      );
                    }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Click to add a family member or a relative!',
                    style: TextStyle(fontSize: 12, color: Color(0xFF939393)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 100,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        print('Add Family Member or Relative');
                      },
                      icon: const Icon(Icons.person_add, color: Colors.white),
                      label: const Text(
                        'Add Person',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0051DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
