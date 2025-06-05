import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AccountOpeningPreviewSection extends StatefulWidget {
  const AccountOpeningPreviewSection({super.key});

  @override
  State<AccountOpeningPreviewSection> createState() =>
      _AccountOpeningPreviewSectionState();
}

class _AccountOpeningPreviewSectionState
    extends State<AccountOpeningPreviewSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: context.theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Preview",
                    style: TextStyle(
                      color: context.theme.colorScheme.onPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  spacing: 10,
                  children: [
                    Center(
                      child: Column(
                        spacing: 10,
                        children: [
                          Text(
                            "Account Info",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Account Holder name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Mr. Johnson",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Operator Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Mr. Johnson",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tenure",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "5 Years",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Interest Rate",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Text(
                                    "12",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.percent, size: 12),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Deposit Amount",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Text(
                                    "50000",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(
                                    FontAwesomeIcons.bangladeshiTakaSign,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Interest Transfer To",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "L-1356",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),

                          Text(
                            "Appointed Nominee",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Md Israfil",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Text(
                                    "60",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.percent, size: 12),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jeremy Johnson",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                spacing: 2,
                                children: [
                                  Text(
                                    "40",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(FontAwesomeIcons.percent, size: 12),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
