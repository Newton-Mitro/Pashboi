import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_background.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';

class FamilyAndRelativesSubmit extends StatefulWidget {
  const FamilyAndRelativesSubmit({super.key});

  @override
  State<FamilyAndRelativesSubmit> createState() =>
      _FamilyAndRelativesSubmitState();
}

class _FamilyAndRelativesSubmitState extends State<FamilyAndRelativesSubmit> {
  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width - 100;

    Widget buildPreviewRow(String label, String value) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        Text(value, style: const TextStyle(color: Colors.white)),
      ],
    );

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
              // Top content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.checkDouble,
                        size: 25,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1),
                        child: Text(
                          "Congratulation!",
                          style: TextStyle(
                            color: context.theme.colorScheme.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Your request has been submitted and waiting for approval",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.theme.colorScheme.onPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.theme.colorScheme.secondary,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              "Preview",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: context.theme.colorScheme.onPrimary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.surface,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildPreviewRow(
                                "Account Holder Name",
                                "Md Israfil",
                              ),
                              const SizedBox(height: 10),
                              buildPreviewRow("Account number", "L-1356"),
                              const SizedBox(height: 10),
                              buildPreviewRow("Relationship", "Brother"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              AppPrimaryButton(
                iconBefore: Icon(Icons.arrow_forward),
                label: "Go to Family & Relatives",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
