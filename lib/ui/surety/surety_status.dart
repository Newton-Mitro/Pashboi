import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

import 'package:pashboi/shared/widgets/page_container.dart';
import 'package:pashboi/ui/new_widget/suerity_list.dart';

class SuretyStatus extends StatefulWidget {
  const SuretyStatus({super.key});

  @override
  State<SuretyStatus> createState() => _SuretyStatusState();
}

final List<Map<String, dynamic>> sureties = [
  {
    "name": "Md Israfil",
    "details": [
      {
        "data": "+880-1615458888",
        "data_desc": "Mobile Number",
        "data_icon": FontAwesomeIcons.phone,
      },
      {
        "data": "T-0099999",
        "data_desc": "Collateral Account",
        "data_icon": FontAwesomeIcons.buildingColumns,
      },
      {
        "data": "G2024012569999",
        "data_desc": "Loan No",
        "data_icon": FontAwesomeIcons.ideal,
      },
      {
        "data": "50000",
        "data_desc": "Loan Amount",
        "data_icon": FontAwesomeIcons.coins,
      },
      {
        "data": "50000",
        "data_desc": "Loan Blance",
        "data_icon": FontAwesomeIcons.scaleBalanced,
      },
      {
        "data": "25-Dec-2024",
        "data_desc": "Valid Till",
        "data_icon": FontAwesomeIcons.calendarCheck,
      },
      {
        "data": "5,00,000",
        "data_desc": "Surety Amount",
        "data_icon": FontAwesomeIcons.fileInvoiceDollar,
      },
      {
        "data": "Paid",
        "data_desc": "Installment",
        "data_icon": FontAwesomeIcons.moneyBill1,
      },
      {
        "data": "14-Jan-2024",
        "data_desc": "Last Paid",
        "data_icon": FontAwesomeIcons.calendarCheck,
      },
      {
        "data": "Active Surety",
        "data_desc": "Surety Status",
        "data_icon": FontAwesomeIcons.fileCircleQuestion,
      },
      {
        "data": "20,000",
        "data_desc": "Surety Release Amount",
        "data_icon": FontAwesomeIcons.fileExport,
      },
    ],
  },
  {
    "name": "Fatema Begum",
    "details": [
      {
        "data": "+880-1615458888",
        "data_desc": "Mobile Number",
        "data_icon": FontAwesomeIcons.phone,
      },
      {
        "data": "T-0099999",
        "data_desc": "Collateral Account",
        "data_icon": FontAwesomeIcons.buildingColumns,
      },
      {
        "data": "G2024012569999",
        "data_desc": "Loan No",
        "data_icon": FontAwesomeIcons.ideal,
      },
      {
        "data": "50000",
        "data_desc": "Loan Amount",
        "data_icon": FontAwesomeIcons.coins,
      },
      {
        "data": "50000",
        "data_desc": "Loan Blance",
        "data_icon": FontAwesomeIcons.scaleBalanced,
      },
      {
        "data": "25-Dec-2024",
        "data_desc": "Valid Till",
        "data_icon": FontAwesomeIcons.calendarCheck,
      },
      {
        "data": "5,00,000",
        "data_desc": "Surety Amount",
        "data_icon": FontAwesomeIcons.fileInvoiceDollar,
      },
      {
        "data": "Paid",
        "data_desc": "Installment",
        "data_icon": FontAwesomeIcons.moneyBill1,
      },
      {
        "data": "14-Jan-2024",
        "data_desc": "Last Paid",
        "data_icon": FontAwesomeIcons.calendarCheck,
      },
      {
        "data": "Active Surety",
        "data_desc": "Surety Status",
        "data_icon": FontAwesomeIcons.fileCircleQuestion,
      },
      {
        "data": "20,000",
        "data_desc": "Surety Release Amount",
        "data_icon": FontAwesomeIcons.fileExport,
      },
    ],
  },
];

class _SuretyStatusState extends State<SuretyStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Surety Status',
              style: TextStyle(
                color: context.theme.colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.onPrimary,
            ),
          ],
        ),
      ),
      body: PageContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  sureties.isEmpty
                      ? Center(
                        child: Text(
                          'You don’t have any surety accounts',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: context.theme.colorScheme.onSurface,
                          ),
                        ),
                      )
                      : Accordion(
                        headerBorderWidth: 3,
                        headerBorderColor: context.theme.colorScheme.secondary,
                        headerBorderColorOpened:
                            context.theme.colorScheme.primary,
                        headerBackgroundColorOpened:
                            context.theme.colorScheme.primary,
                        contentBackgroundColor:
                            context.theme.colorScheme.surface,
                        contentBorderColor: context.theme.colorScheme.secondary,
                        contentBorderWidth: 3,
                        contentHorizontalPadding: 20,
                        scaleWhenAnimating: true,
                        openAndCloseAnimation: true,
                        headerPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        sectionOpeningHapticFeedback:
                            SectionHapticFeedback.heavy,
                        sectionClosingHapticFeedback:
                            SectionHapticFeedback.light,
                        children:
                            sureties.map((surety) {
                              return AccordionSection(
                                isOpen: false,
                                contentVerticalPadding: 20,
                                leftIcon: const Icon(
                                  FontAwesomeIcons.user,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                header: Text(
                                  surety['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                content: SuerityList(
                                  sueritylist: surety['details'],
                                ),
                              );
                            }).toList(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
