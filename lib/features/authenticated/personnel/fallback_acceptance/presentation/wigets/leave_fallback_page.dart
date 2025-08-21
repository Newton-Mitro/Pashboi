import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/app_time_picker.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveFallbackPage extends StatefulWidget {
  const LeaveFallbackPage({super.key});

  @override
  State<LeaveFallbackPage> createState() => _LeaveFallbackPageState();
}

class _LeaveFallbackPageState extends State<LeaveFallbackPage> {
  // Controllers
  final TextEditingController _employeeIdController = TextEditingController();
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
  void dispose() {
    _employeeIdController.dispose();
    _employeeNameController.dispose();
    _totalDaysController.dispose();
    _reasonController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fallback Acceptance Details")),
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
                          "Fallback Approval",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    AppDropdownSelect(
                      label: "Leave Type",
                      value: '',
                      enabled: false,
                      items: [],
                      prefixIcon: FontAwesomeIcons.addressBook,
                      onChanged: (value) {},
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

                    _buildTextArea(
                      controller: _remarksController,
                      label: "Fallback Approval Remarks",
                    ),
                    const SizedBox(height: 16),

                    AppPrimaryButton(
                      label: "Submit",
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Fallback Accepted Successfully"),
                          ),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
}
