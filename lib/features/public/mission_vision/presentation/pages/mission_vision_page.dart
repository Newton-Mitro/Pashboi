import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class MissionAndVisionPage extends StatefulWidget {
  const MissionAndVisionPage({super.key});

  @override
  State<MissionAndVisionPage> createState() => _MissionAndVisionPageState();
}

class _MissionAndVisionPageState extends State<MissionAndVisionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mission and Vision'),
        backgroundColor: context.theme.colorScheme.primary,
        foregroundColor: context.theme.colorScheme.onPrimary,
        elevation: 0,
      ),
      body: Text("data"),
    );
  }
}
