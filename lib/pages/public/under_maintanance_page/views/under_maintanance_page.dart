import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/app_context.dart';
import 'package:pashboi/core/widgets/app_logo.dart';

class UnderMaintenancePage extends StatelessWidget {
  const UnderMaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo
                AppLogo(width: 150, height: 150),

                const SizedBox(height: 32),

                // Title
                Text(
                  context.appLocalizations.underMaintenanceTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  context.appLocalizations.underMaintenanceMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // Exit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: context.theme.colorScheme.primary,
                    foregroundColor: context.theme.colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    exit(0); // <-- Exit the app
                  },
                  child: const Text('Exit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
