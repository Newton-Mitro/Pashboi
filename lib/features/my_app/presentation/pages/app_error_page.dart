import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_logo.dart';

class AppErrorPage extends StatelessWidget {
  final String message;

  const AppErrorPage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // Locales.string(context, 'error_page_title'),
          'Error',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppLogo(width: 150),

                const SizedBox(height: 32),

                Text(
                  // Locales.string(context, 'error_page_title'),
                  'Oops! Something went wrong',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

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
                  onPressed: () => exit(0),
                  child: Text(
                    // Locales.string(context, 'error_page_exit_button'),
                    'Exit',
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
