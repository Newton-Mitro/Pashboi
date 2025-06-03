import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    final double cardHeight =
        context.isMobile
            ? MediaQuery.of(context).size.height * 0.27
            : MediaQuery.of(context).size.height * 0.5;

    final double cardWidth = cardHeight * 2.0;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('My Cards')],
        ),
      ),
      body: PageContainer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 3.0,
                shadowColor: Colors.black,
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Background image
                      Image.asset(
                        'assets/images/bg/card_bg.png', // update this path as needed
                        fit: BoxFit.cover,
                      ),

                      // Foreground content
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLogo(width: 80, showOrganizationName: false),
                                Text(
                                  "Virtual Card".toUpperCase(),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
                                      color:
                                          context.theme.colorScheme.onSurface,
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
                                  "eLina Jane Smith".toUpperCase(),
                                  style: TextStyle(
                                    color: context.theme.colorScheme.onSurface,
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
                                        color:
                                            context.theme.colorScheme.onSurface,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "12/26",
                                      style: TextStyle(
                                        color:
                                            context.theme.colorScheme.onSurface,
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
