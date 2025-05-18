import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonnelMenusView extends StatefulWidget {
  const PersonnelMenusView({super.key});

  @override
  State<PersonnelMenusView> createState() => _PersonnelMenusViewState();
}

class _PersonnelMenusViewState extends State<PersonnelMenusView> {
  final List<Map<String, dynamic>> infoMenus = [
    {
      "icon": FontAwesomeIcons.calendarDays,
      "menuName": "Leave Application",
      "menuDescription":
          "Submit a formal request for leave, specifying the dates and type of leave",
    },
    {
      "icon": FontAwesomeIcons.circleCheck,
      "menuName": "Fallback Acceptance",
      "menuDescription":
          "Approve or decline fallback leave requests based on availability and company policy",
    },
    {
      "icon": FontAwesomeIcons.thumbsUp,
      "menuName": "Leave Approval",
      "menuDescription":
          "Review and approve or reject pending leave requests from employees",
    },
    {
      "icon": FontAwesomeIcons.clockRotateLeft,
      "menuName": "Leave History",
      "menuDescription":
          "View and manage a history of your approved or denied leave applications",
    },
    {
      "icon": FontAwesomeIcons.clock,
      "menuName": "Attendance",
      "menuDescription":
          "Track your attendance records, including working hours and absences",
    },
    {
      "icon": FontAwesomeIcons.houseLaptop,
      "menuName": "Working Out of Office Application",
      "menuDescription":
          "Submit a request to work remotely or outside the office for a specified period",
    },
    {
      "icon": FontAwesomeIcons.squareCheck,
      "menuName": "Working Out of Office Approval",
      "menuDescription":
          "Review and approve or reject employee requests to work outside the office",
    },

    {
      "icon": Icons.file_copy,
      "menuName": "Working Out of Office History",
      "menuDescription":
          "View your history of approved or denied working out of office applications",
    },
    {
      "icon": Icons.fingerprint,
      "menuName": "Today's Punch",
      "menuDescription":
          "Record your in and out times for attendance on the current day",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: infoMenus.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final menu = infoMenus[index];
            return MenuTile(
              icon: Icon(
                menu['icon'],
                size: 35,
                color: context.theme.colorScheme.onPrimary,
              ),
              menuName: menu['menuName'],
              menuDescription: menu['menuDescription'],
              onTap: () {
                debugPrint("Tapped on ${menu['menuName']}");
              },
            );
          },
        ),
      ),
    );
  }
}
