import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/app_icon_card.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveApprovalPage extends StatefulWidget {
  const LeaveApprovalPage({super.key});

  @override
  State<LeaveApprovalPage> createState() => _LeaveApprovalPageState();
}

class _LeaveApprovalPageState extends State<LeaveApprovalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Approval")),
      body: PageContainer(child: SingleChildScrollView(child: _buildForm())),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIconCard(
            leftIcon: FontAwesomeIcons.mugHot,
            rightIcon: FontAwesomeIcons.chevronRight,
            boarderColor: context.theme.colorScheme.primary,
            cardBody: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(" Leave Request from John Doe"),
                const SizedBox(height: 5),
                Text("From: 2024-06-01"),
                Text("To: 2024-06-05"),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                AuthRoutesName.leaveApprovalDetailsPage,
                // arguments: {'fallbackRequest': requestList[index]},
              );
            },
          ),
        ],
      ),
    );
  }
}
