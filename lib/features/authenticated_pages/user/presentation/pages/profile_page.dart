import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool? _isCheck = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    Widget buildInfoRow(IconData icon, String title, String value) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary.withOpacity(0.8),
            ),
            child: Icon(icon, size: 24, color: theme.colorScheme.onPrimary),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14)),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Profile')],
        ),
      ),
      body: PageContainer(
        child: Container(
          color: theme.colorScheme.primary.withOpacity(0.1),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.surface,
                          border: Border.all(
                            color: theme.colorScheme.secondary,
                            width: 5,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            'https://images.pexels.com/photos/1704488/pexels-photo-1704488.jpeg?cs=srgb&dl=pexels-sulimansallehi-1704488.jpg&fm=jpg',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                            errorBuilder:
                                (context, error, stackTrace) =>
                                    Icon(Icons.error),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.primary,
                            border: Border.all(
                              color: theme.colorScheme.secondary,
                              width: 3,
                            ),
                          ),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            size: 18,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Md Israfil",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "israfil@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Are you available for blood donation?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          value: _isCheck,
                          onChanged:
                              (value) => setState(() => _isCheck = value),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Join our community of life-savers. If you're eligible and willing, you can now register as a blood donor and help someone in need—because saving lives is priceless.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    buildInfoRow(
                      FontAwesomeIcons.baby,
                      "Date Of Birth",
                      "1984-11-01",
                    ),
                    buildInfoRow(FontAwesomeIcons.droplet, "Blood Group", "A+"),
                    buildInfoRow(FontAwesomeIcons.idCard, "NID", "7311223056"),
                    buildInfoRow(
                      FontAwesomeIcons.phoneVolume,
                      "Mobile Number",
                      "+880-1815458842",
                    ),
                    buildInfoRow(
                      FontAwesomeIcons.locationPin,
                      "Present Address",
                      "345, East Street, NY",
                    ),
                    buildInfoRow(
                      FontAwesomeIcons.locationPinLock,
                      "Permanent Address",
                      "345, East Street, NY",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
