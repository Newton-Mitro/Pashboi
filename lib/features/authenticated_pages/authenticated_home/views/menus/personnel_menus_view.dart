import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/menu_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonnelMenusView extends StatefulWidget {
  const PersonnelMenusView({super.key});

  @override
  State<PersonnelMenusView> createState() => _PersonnelMenusViewState();
}

class _PersonnelMenusViewState extends State<PersonnelMenusView> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> infoMenus = [
      {
        "icon": FontAwesomeIcons.calendarDays,
        "menuName": Locales.string(
          context,
          "personnel_menu_leave_application_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_leave_application_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.circleCheck,
        "menuName": Locales.string(
          context,
          "personnel_menu_fallback_acceptance_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_fallback_acceptance_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.thumbsUp,
        "menuName": Locales.string(
          context,
          "personnel_menu_leave_approval_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_leave_approval_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.clockRotateLeft,
        "menuName": Locales.string(
          context,
          "personnel_menu_leave_history_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_leave_history_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.clock,
        "menuName": Locales.string(context, "personnel_menu_attendance_title"),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_attendance_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.houseLaptop,
        "menuName": Locales.string(
          context,
          "personnel_menu_working_out_of_office_application_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_working_out_of_office_application_description",
        ),
      },
      {
        "icon": FontAwesomeIcons.squareCheck,
        "menuName": Locales.string(
          context,
          "personnel_menu_working_out_of_office_approval_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_working_out_of_office_approval_description",
        ),
      },

      {
        "icon": Icons.file_copy,
        "menuName": Locales.string(
          context,
          "personnel_menu_working_out_of_office_history_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_working_out_of_office_history_description",
        ),
      },
      {
        "icon": Icons.fingerprint,
        "menuName": Locales.string(
          context,
          "personnel_menu_todays_punch_title",
        ),
        "menuDescription": Locales.string(
          context,
          "personnel_menu_todays_punch_description",
        ),
      },
    ];
    return SafeArea(
      child: ListView.separated(
        itemCount: infoMenus.length,
        padding: const EdgeInsets.all(12),
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
    );
  }
}
