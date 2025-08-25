import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveApprovalDetailsPage extends StatefulWidget {
  const LeaveApprovalDetailsPage({super.key});

  @override
  State<LeaveApprovalDetailsPage> createState() =>
      _LeaveApprovalDetailsPageState();
}

class _LeaveApprovalDetailsPageState extends State<LeaveApprovalDetailsPage> {
  final TextEditingController _leaveTypeController = TextEditingController();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _totalDaysController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  // Time values
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  // Date values
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _rejoinDate;

  @override
  Widget _buildTextArea({
    required TextEditingController controller,
    required String label,
    bool enabled = true,
  }) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      maxLines: null,
      minLines: 2,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.edit_note),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a value';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Approval Details")),
      body: PageContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          " Leave Approval Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    AppTextInput(
                      controller: _leaveTypeController,
                      label: 'Leave Type',
                      prefixIcon: Icon(
                        FontAwesomeIcons.addressBook,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      enabled: false,
                      errorText: '',
                    ),
                    const SizedBox(height: 12),

                    AppTextInput(
                      controller: _employeeNameController,
                      label: 'Fallback Employee Name',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      enabled: false,
                      errorText: '',
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: AppDatePicker(
                            selectedDate: _startDate,
                            onDateChanged:
                                (d) => setState(() => _startDate = d),
                            label: "Start Date",
                            errorText: '',
                            firstDate: null,
                            enabled: false,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppDatePicker(
                            selectedDate: _endDate,
                            onDateChanged: (d) => setState(() => _endDate = d),
                            label: "End Date",
                            errorText: '',
                            firstDate: null,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextInput(
                            controller: _totalDaysController,
                            label: 'Total Day(s)',
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: context.theme.colorScheme.onSurface,
                            ),
                            enabled: false,
                            errorText: '',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppDatePicker(
                            selectedDate: _rejoinDate,
                            onDateChanged:
                                (d) => setState(() => _rejoinDate = d),
                            label: "Rejoin Date",
                            errorText: '',
                            firstDate: null,
                            lastDate: null,
                            enabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    _buildTextArea(
                      controller: _reasonController,
                      label: "Reason for Leave",
                      enabled: false,
                    ),
                    const SizedBox(height: 12),

                    AppTextInput(
                      controller: _totalDaysController,
                      label: 'Application Status',
                      prefixIcon: Icon(
                        FontAwesomeIcons.faceSmile,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      enabled: false,
                      errorText: '',
                    ),
                    const SizedBox(height: 12),

                    _buildTextArea(
                      controller: _remarksController,
                      label: "Fallback Approval Remarks",
                    ),
                    const SizedBox(height: 16),

                    AppPrimaryButton(label: "Submit", onPressed: () {}),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
