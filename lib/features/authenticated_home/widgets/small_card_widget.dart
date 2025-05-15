import 'package:flutter/material.dart';

class SmaillCard extends StatelessWidget {
  const SmaillCard({
    super.key,
    required this.icon,
    required this.heading,
    required this.subHeading,
  });

  final Icon icon;
  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF0051DA), width: 0.5),
        borderRadius: BorderRadius.circular(6),
        // boxShadow: const [
        //   BoxShadow(
        //     color: const Color(0xFF0051DA),
        //     blurRadius: 5,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF021D48),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [icon, const SizedBox(height: 10)],
              ),
            ),
          ),

          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subHeading,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
