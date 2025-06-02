import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DebitCardPage extends StatefulWidget {
  const DebitCardPage({super.key});

  @override
  State<DebitCardPage> createState() => _DebitCardPageState();
}

class _DebitCardPageState extends State<DebitCardPage> {
  @override
  Widget build(BuildContext context) {
    final double cardHeight;
    if (context.isMobile) {
      cardHeight = MediaQuery.of(context).size.height * 0.27;
    } else if (context.isTablet) {
      cardHeight = MediaQuery.of(context).size.height * 0.5;
    } else {
      cardHeight = MediaQuery.of(context).size.height * 0.5;
    }

    final double cardWidth = cardHeight * 2.0;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cards',
              style: TextStyle(
                color: context.theme.colorScheme.surface,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              FontAwesomeIcons.house,
              size: 20,
              color: context.theme.colorScheme.surface,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: PageContainer(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: cardWidth,
                      height: cardHeight,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: context.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Virtual Card".toUpperCase(),
                              style: TextStyle(
                                color: context.theme.colorScheme.surface,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "ACTIVE",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                ),
                                Text(
                                  "1234456845681235".replaceAllMapped(
                                    RegExp(r".{1,4}"),
                                    (match) =>
                                        match.end < 16
                                            ? "${match.group(0)}   "
                                            : match.group(0)!,
                                  ),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.surface,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MD ISRAFIL",
                                style: TextStyle(
                                  color: context.theme.colorScheme.surface,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Valid Thru",
                                    style: TextStyle(
                                      color: context.theme.colorScheme.surface,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    "12/26",
                                    style: TextStyle(
                                      color: context.theme.colorScheme.surface,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
