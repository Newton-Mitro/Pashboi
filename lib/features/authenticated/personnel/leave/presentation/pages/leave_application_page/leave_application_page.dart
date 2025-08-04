import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/get_leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/leave_type_bloc.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  String? selectedLeaveType;

  @override
  void initState() {
    super.initState();
    context.read<LeaveTypeBloc>().add(FetchLeaveTypeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Application")),
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
                    borderRadius: BorderRadius.circular(5),
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
                            } else if (state is LeaveTypeSuccess) {
                              final List<LeaveTypeEntity> leaveTypes =
                                  state.leaveTypeEntity;

                              return AppDropdownSelect(
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
                              );
                            } else if (state is LeaveTypeError) {
                              return Text(
                                "Error: ${state.message}",
                                style: TextStyle(
                                  color: context.theme.colorScheme.error,
                                ),
                              );
                            }

                            // Default empty state
                            return const SizedBox.shrink();
                          },
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
