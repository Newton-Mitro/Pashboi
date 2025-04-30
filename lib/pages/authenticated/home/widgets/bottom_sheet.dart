import 'package:flutter/material.dart';
import 'package:pashboi/app_configs/routes/route_name.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/app_logo.dart';
import 'package:pashboi/pages/authenticated/home/widgets/button_widget.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.theme.colorScheme.primary,
            context.theme.colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const AppLogo(width: 100, height: 100),
          const SizedBox(height: 50),
          CustomButton(context, 'Login', RoutesName.loginPage),
          const SizedBox(height: 10),
          const Text(
            'or',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          CustomButton(context, 'Register', RoutesName.registerPage),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return const CustomBottomSheet();
    },
  );
}
