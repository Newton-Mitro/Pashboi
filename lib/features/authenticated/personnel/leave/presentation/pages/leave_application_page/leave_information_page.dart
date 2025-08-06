import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/get_leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/leave_type_bloc.dart';
import 'package:pashboi/routes/auth_routes_name.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveInformationPage extends StatefulWidget {
  const LeaveInformationPage({super.key});

  @override
  State<LeaveInformationPage> createState() => _LeaveInformationPageState();
}

class _LeaveInformationPageState extends State<LeaveInformationPage> {
  String? selectedLeaveType;

  @override
  void initState() {
    super.initState();
    context.read<LeaveTypeBloc>().add(FetchLeaveTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Info")),
      body: PageContainer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                  color: context.theme.colorScheme.surface,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: context.theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ListTile(
                          title: Text(
                            "Leave Information",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Dropdown from Bloc
                        BlocBuilder<LeaveTypeBloc, LeaveTypeState>(
                          builder: (context, state) {
                            if (state is LeaveTypeLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (state is LeaveTypeError) {
                              return Text(
                                state.message,
                                style: TextStyle(
                                  color: context.theme.colorScheme.error,
                                ),
                              );
                            }

                            if (state is LeaveTypeSuccess) {
                              final List<LeaveTypeEntity> leaveTypes =
                                  state.leaveTypeEntity;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  AppDropdownSelect(
                                    label: "Leave Type",
                                    value: selectedLeaveType,
                                    enabled: leaveTypes.isNotEmpty,
                                    items:
                                        leaveTypes.map((leaveType) {
                                          return DropdownMenuItem(
                                            value: leaveType.id,
                                            child: Text(leaveType.leaveType),
                                          );
                                        }).toList(),
                                    prefixIcon: FontAwesomeIcons.addressBook,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLeaveType = value;
                                      });
                                    },
                                  ),

                                  const SizedBox(height: 12),

                                  // Separate Card for Entitlement
                                  Column(
                                    children: [
                                      // First item
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: const [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Annual Entitlement",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text("20.0"),
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),

                                      // Second item (duplicate)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: const [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Total Approved Leave ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text("0"),
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: const [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Balance",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text("14.25"),
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 12,
                                        ),
                                        child: Row(
                                          children: const [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Last Application Date",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Text("14.25"),
                                          ],
                                        ),
                                      ),
                                      const Divider(thickness: 1.5),

                                      AppPrimaryButton(
                                        label: "Apply For Leave",
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            AuthRoutesName.leaveApplication,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: context.theme.colorScheme.surface,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: context.theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const ListTile(
                          title: Text(
                            "Leave Balance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                // First item
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    children: const [
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 16),
                                          SizedBox(width: 8),
                                          Text(
                                            "Earn Leave",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Text("20.0"),
                                    ],
                                  ),
                                ),
                                const Divider(thickness: 1.5),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
