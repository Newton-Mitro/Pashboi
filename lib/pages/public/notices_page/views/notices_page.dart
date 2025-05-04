import 'package:flutter/material.dart';

class NoticesPage extends StatefulWidget {
  const NoticesPage({super.key});

  @override
  State<NoticesPage> createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  final List<Map<String, String>> notices = [
    {
      'title': 'Holiday Notice',
      'description':
          'The office will remain closed on May 5th due to a public holiday.',
      'icon': '📅',
    },
    {
      'title': 'New Deposit Scheme',
      'description': 'Introducing our new high-interest fixed deposit scheme.',
      'icon': '💰',
    },
    {
      'title': 'System Maintenance',
      'description':
          'Scheduled maintenance on May 10th from 12:00 AM to 3:00 AM.',
      'icon': '🛠️',
    },
    {
      'title': 'Loan Rate Change',
      'description':
          'Revised interest rates for home loans effective from June 1st.',
      'icon': '📉',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notices')),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Text(
                notice['icon'] ?? '',
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(notice['title'] ?? ''),
              subtitle: Text(notice['description'] ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Add navigation or detail dialog if needed
              },
            ),
          );
        },
      ),
    );
  }
}
