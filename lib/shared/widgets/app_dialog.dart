import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onSubmit,
  });

  final String title;
  final String content;
  final Icon icon;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.yellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Expanded(flex: 12, child: icon)],
                ),
              ],
            ),
            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Content
            Text(content, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onSubmit();
                  },
                  child: const Text("Submit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
