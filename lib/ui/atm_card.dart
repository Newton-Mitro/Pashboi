import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class AtmCard extends StatefulWidget {
  const AtmCard({super.key});

  @override
  State<AtmCard> createState() => _AtmCardState();
}

class _AtmCardState extends State<AtmCard> {
  @override
  Widget build(BuildContext context) {
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
                fontFamily: 'Roboto',
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // horizontal centering
                children: [
                  Container(
                    width: 400,
                    height: 200,
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 5.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              "Virtual Card",
                              style: TextStyle(
                                color: context.theme.colorScheme.surface,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, top: 12.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Image.asset(
                              "assets/card/chip.png",
                              width: 45,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            "1234 4568 4568 1235",
                            style: TextStyle(
                              color: context.theme.colorScheme.surface,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25.0),
                              child: Text(
                                "MD ISRAFIL",
                                style: TextStyle(
                                  color: context.theme.colorScheme.surface,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25.0),
                              child: Column(
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
