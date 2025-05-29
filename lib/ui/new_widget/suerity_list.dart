import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class SuerityList extends StatelessWidget {
  final List<Map<String, dynamic>> sueritylist;

  const SuerityList({super.key, required this.sueritylist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          sueritylist.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        item['data_icon'],
                        size: 15,
                        color: context.theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item['data_desc'],
                        style: TextStyle(
                          color: context.theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    item['data'],
                    style: TextStyle(
                      color: context.theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}
