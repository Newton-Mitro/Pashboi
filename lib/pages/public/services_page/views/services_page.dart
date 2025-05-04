import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<Map<String, String>> services = [
    {
      'name': 'Mobile Banking',
      'description': 'Access your account anytime, anywhere.',
      'icon': '📱',
    },
    {
      'name': 'ATM Service',
      'description': 'Withdraw cash easily from our wide ATM network.',
      'icon': '🏧',
    },
    {
      'name': 'Online Loan Application',
      'description': 'Apply for loans directly from our app or website.',
      'icon': '📝',
    },
    {
      'name': 'Customer Support',
      'description': 'Reach us anytime for help with services.',
      'icon': '🤝',
    },
    {
      'name': 'Ambulance Service',
      'description': '24/7 emergency medical transport for members.',
      'icon': '🚑',
    },
    {
      'name': 'Gym Facility',
      'description': 'Modern gym with professional trainers.',
      'icon': '🏋️‍♂️',
    },
    {
      'name': 'Child Care',
      'description': 'Daycare services for working parents.',
      'icon': '👶',
    },
    {
      'name': 'School',
      'description': 'Affordable education with experienced teachers.',
      'icon': '🏫',
    },
    {
      'name': 'Guest House',
      'description': 'Comfortable stay for members and guests.',
      'icon': '🏨',
    },
    {
      'name': 'IELTS Coaching',
      'description': 'Expert guidance for IELTS preparation.',
      'icon': '🎓',
    },
    {
      'name': 'Cultural Academy',
      'description': 'Promoting arts, music, and cultural education.',
      'icon': '🎭',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Locales.string(context, 'services_and_projects')),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Text(
                service['icon'] ?? '',
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(service['name'] ?? ''),
              subtitle: Text(service['description'] ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Optionally navigate to a details screen
              },
            ),
          );
        },
      ),
    );
  }
}
