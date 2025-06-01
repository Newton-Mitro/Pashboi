import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class ListFamilyAndRelatives extends StatelessWidget {
  const ListFamilyAndRelatives({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.requestStatus,
    this.onTap,
  });
  final String titleText;
  final String subtitleText;
  final String requestStatus; // Added buttonText for consistency
  final VoidCallback? onTap; // use VoidCallback instead of CallbackAction?

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // needed for InkWell to show ripple

      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 9,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitleText,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.normal,
                      color: context.theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: BoxDecoration(
                      color:
                          requestStatus == "Approved"
                              ? context.theme.colorScheme.tertiary
                              : context.theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      requestStatus,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.normal,
                        color:
                            requestStatus == "Approved"
                                ? context.theme.colorScheme.onTertiary
                                : context.theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
