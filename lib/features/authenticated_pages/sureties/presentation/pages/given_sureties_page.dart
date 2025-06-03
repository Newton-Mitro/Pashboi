import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:pashboi/features/authenticated_pages/sureties/presentation/pages/suerity_details.dart';

import 'package:pashboi/shared/widgets/page_container.dart';

class GivenSuretiesPage extends StatefulWidget {
  const GivenSuretiesPage({super.key});

  @override
  State<GivenSuretiesPage> createState() => _GivenSuretiesPageState();
}

class _GivenSuretiesPageState extends State<GivenSuretiesPage> {
  final List<Map<String, dynamic>> sureties = [
    {
      "LoanId": "D20230729105897",
      "LoanOpenDate": "2023-07-29T18:08:47.503",
      "MemberAccount": "0050829",
      "MemberName": "BAPPY BESRA",
      "MemberMobileNo": "+8801815458842",
      "LoanAmount": 40000,
      "LoanBalance": 40000,
      "SuretyAmount": 1000,
      "StartDate": "2023-07-29T18:08:47.503",
      "EndDate": "2024-01-24T18:08:47.503",
      "Remarks": "",
      "LastPaidDate": "2023-08-07T00:00:00",
      "DefaulterStatus": false,
      "DefaultDetails": "",
      "SuretyStatus": "Active Surety",
      "SuretyReleaseAmount": 1000,
    },
    {
      "LoanId": "D20230729105898",
      "LoanOpenDate": "2023-07-29T18:08:47.503",
      "MemberAccount": "0050830",
      "MemberName": "JOHN DOE",
      "MemberMobileNo": "+8801815458843",
      "LoanAmount": 50000,
      "LoanBalance": 50000,
      "SuretyAmount": 2000,
      "StartDate": "2023-07-29T18:08:47.503",
      "EndDate": "2024-01-24T18:08:47.503",
      "Remarks": "",
      "LastPaidDate": "2023-08-07T00:00:00",
      "DefaulterStatus": true,
      "DefaultDetails": "",
      "SuretyStatus": "Active Surety",
      "SuretyReleaseAmount": 2000,
    },
    {
      "LoanId": "D20230729105899",
      "LoanOpenDate": "2023-07-29T18:08:47.503",
      "MemberAccount": "0050831",
      "MemberName": "JOHN DOE",
      "MemberMobileNo": "+8801815458844",
      "LoanAmount": 60000,
      "LoanBalance": 60000,
      "SuretyAmount": 3000,
      "StartDate": "2023-07-29T18:08:47.503",
      "EndDate": "2024-01-24T18:08:47.503",
      "Remarks": "",
      "LastPaidDate": "2023-08-07T00:00:00",
      "DefaulterStatus": false,
      "DefaultDetails": "",
      "SuretyStatus": "Active Surety",
      "SuretyReleaseAmount": 3000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Surety Status')),
      body: PageContainer(
        child: Column(
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
                        headerBorderColor: context.theme.colorScheme.primary,
                        headerBorderColorOpened:
                            context.theme.colorScheme.primary,
                        headerBackgroundColorOpened:
                            context.theme.colorScheme.primary,
                        contentBackgroundColor:
                            context.theme.colorScheme.surface,
                        contentBorderColor: context.theme.colorScheme.primary,
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
                                headerBackgroundColor:
                                    surety['DefaulterStatus'] == true
                                        ? context.theme.colorScheme.error
                                        : context.theme.colorScheme.primary,
                                headerBackgroundColorOpened:
                                    surety['DefaulterStatus'] == true
                                        ? context.theme.colorScheme.error
                                        : context.theme.colorScheme.primary,
                                headerBorderColor:
                                    surety['DefaulterStatus'] == true
                                        ? context.theme.colorScheme.error
                                        : context.theme.colorScheme.primary,
                                contentBorderColor:
                                    surety['DefaulterStatus'] == true
                                        ? context.theme.colorScheme.error
                                        : context.theme.colorScheme.primary,
                                isOpen: false,
                                contentVerticalPadding: 20,
                                leftIcon: Icon(
                                  FontAwesomeIcons.personCircleCheck,
                                  size: 20,
                                  color: context.theme.colorScheme.onPrimary,
                                ),
                                header: Text(
                                  surety['MemberName'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: context.theme.colorScheme.onPrimary,
                                  ),
                                ),
                                content: SuerityDetails(surety: surety),
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
