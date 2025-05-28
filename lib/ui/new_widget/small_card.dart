import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    super.key,
    required this.gender,
    required this.titleText,
    required this.subtitleText,
    required this.requestStatus,
    this.onTap,
  });

  final String gender;
  final String titleText;
  final String subtitleText;
  final String requestStatus; // Added buttonText for consistency
  final VoidCallback? onTap; // use VoidCallback instead of CallbackAction?

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // needed for InkWell to show ripple
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.theme.colorScheme.secondary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    child: SizedBox.expand(
                      child: Center(
                        child: Icon(
                          gender == 'male' ? Icons.man : Icons.woman,
                          size: 30,
                          color: context.theme.colorScheme.onSurface,
                        ), // Replace with `icon` if dynamic
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 20,
                    ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 0,
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
