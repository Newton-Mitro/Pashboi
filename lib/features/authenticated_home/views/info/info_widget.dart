import 'package:flutter/material.dart';
import 'package:pashboi/features/authenticated_home/widgets/small_card_widget.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF01122F),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            spacing: 20,
            children: const [
              SmaillCard(
                icon: Icon(
                  Icons.account_balance,
                  size: 35,
                  color: const Color(0xFF86ABE3),
                ),
                heading: "Dependent’s Account’s",
                subHeading:
                    "Place for all your dependent accounts.your dependent accounts.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
