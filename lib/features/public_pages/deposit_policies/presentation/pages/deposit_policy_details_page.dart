import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class DepositPolicyDetailsPage extends StatelessWidget {
  const DepositPolicyDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const imageUrl =
        'https://t3.ftcdn.net/jpg/02/36/99/22/360_F_236992283_sNOxCVQeFLd5pdqaKGh8DRGMZy7P4XKm.jpg';

    var showIcon = imageUrl.isEmpty ? true : false;
    return Scaffold(
      appBar: AppBar(title: const Text('Page Details'), elevation: 0),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              showIcon
                  ? Container(
                    alignment: Alignment.center,
                    height: 200,
                    width: double.infinity,
                    child: FaIcon(
                      FontAwesomeIcons.piggyBank,
                      size: 150,
                      color: context.theme.colorScheme.primary,
                    ),
                  )
                  : Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              const SizedBox(height: 16),
              const Text(
                'Title Goes Here',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    'Published on: ${DateTime.now().toString().split(' ')[0]}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Posted By: Dhaka Credit',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(fontSize: 16, height: 1.6),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
