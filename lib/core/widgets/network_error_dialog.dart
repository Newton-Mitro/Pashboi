import 'package:flutter/material.dart';
import 'package:pashboi/core/utils/network_utils.dart';

class NetworkErrorDialog extends StatefulWidget {
  const NetworkErrorDialog({super.key});

  @override
  State<NetworkErrorDialog> createState() => _NetworkErrorDialogState();

  // Static method to show the dialog
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const NetworkErrorDialog(),
    );
  }
}

class _NetworkErrorDialogState extends State<NetworkErrorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: AlertDialog(
        title: const Text("Network Error"),
        content: const Text(
          "No internet connection. Please check your network settings.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          TextButton(
            onPressed: () {
              NetworkUtils.openInternetSettings();
              Navigator.pop(context);
            },
            child: Text(
              "Open Settings",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
