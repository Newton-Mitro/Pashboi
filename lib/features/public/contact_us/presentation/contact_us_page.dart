import 'package:flutter/material.dart';
// Import your reusable dynamic page widget here

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  final List<Map<String, String>> pages = const [
    {'title': 'Founder Profile', 'slug': 'founders-profile', 'icon': '👤'},
    {'title': 'About Us', 'slug': 'about-us', 'icon': 'ℹ️'},
    {'title': 'Policy', 'slug': 'policy', 'icon': '📄'},
    {'title': 'Contact Us', 'slug': 'contact-us', 'icon': '📞'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Information Pages')),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Text(
                page['icon'] ?? '',
                style: const TextStyle(fontSize: 28),
              ),
              title: Text(page['title'] ?? ''),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => DynamicPageView(
                //       pageSlug: page['slug']!,
                //       title: page['title']!,
                //     ),
                //   ),
                // );
              },
            ),
          );
        },
      ),
    );
  }
}
