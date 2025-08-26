import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/search_employee_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/search_employee_bloc.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/submit_leave_application_bloc.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/app_time_picker.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveApplicationPage extends StatefulWidget {
  final String selectedLeaveTypeId;
  final List<LeaveTypeEntity> leaveTypes;

  const LeaveApplicationPage({
    super.key,
    required this.selectedLeaveTypeId,
    required this.leaveTypes,
  });

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  String? selectedLeaveType;
  final TextEditingController _accountSearchController =
      TextEditingController();

  TimeOfDay? _startTimeController;
  TimeOfDay? _endTimeController;

  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _totalDaysController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DateTime startDate;
  late DateTime endDate;
  late DateTime rejoinDate;

  String? _errorText;

  @override
  void initState() {
    super.initState();
    selectedLeaveType =
        widget.selectedLeaveTypeId.isNotEmpty
            ? widget.selectedLeaveTypeId
            : null;
    final today = DateTime.now();
    startDate = today;
    endDate =
        selectedLeaveType == '02' ? today : today.add(const Duration(days: 1));
    rejoinDate = endDate.add(const Duration(days: 1));
    _updateTotalDays();
    selectedLeaveType =
        widget.selectedLeaveTypeId.isNotEmpty
            ? widget.selectedLeaveTypeId
            : null;
  }

  void _handleDateChange(DateTime date, {required String field}) {
    setState(() {
      if (field == 'from') {
        startDate = date;
        // if (!endDate.isAfter(startDate)) {
        //   endDate = startDate.add(const Duration(days: 1));
        // }
      } else if (field == 'to') {
        endDate = date;
      } else if (field == 'rejoin') {
        rejoinDate = date;
      }

      _updateTotalDays();
    });
  }

  void _updateTotalDays() {
    final days = endDate.difference(startDate).inDays + 1;
    _totalDaysController.text = days > 0 ? days.toString() : '0';
  }

  Widget _buildDatePicker({
    required DateTime date,
    required String label,
    required String field,
  }) {
    return AppDatePicker(
      selectedDate: date,
      onDateChanged: (d) => _handleDateChange(d!, field: field),
      label: label,
      errorText: _errorText,
      firstDate:
          (selectedLeaveType == '01' || selectedLeaveType == '04')
              ? DateTime.now()
              : null,
      lastDate: selectedLeaveType == '02' ? DateTime.now() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Application")),
      body: PageContainer(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Card(
      color: context.theme.colorScheme.surface,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.theme.colorScheme.primary, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ListTile(
              title: Text(
                "Leave Application",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            AppDropdownSelect(
              label: "Leave Type",
              value: selectedLeaveType,
              enabled: widget.leaveTypes.isNotEmpty,
              items:
                  widget.leaveTypes
                      .map(
                        (type) => DropdownMenuItem(
                          value: type.id,
                          child: Text(type.leaveType),
                        ),
                      )
                      .toList(),
              prefixIcon: FontAwesomeIcons.addressBook,
              onChanged: (value) => setState(() => selectedLeaveType = value),
            ),
            const SizedBox(height: 16),
            (selectedLeaveType != '02' &&
                    selectedLeaveType != '03' &&
                    selectedLeaveType != '07')
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSearchTextInput(
                      controller: _accountSearchController,
                      label: "Fallback Employee Id",
                      isSearch: true,
                      enabled: true,
                      prefixIcon: Icon(
                        FontAwesomeIcons.userTie,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      errorText: '',
                      onSearchPressed: () {
                        final searchText = _accountSearchController.text.trim();
                        context.read<SearchEmployeeBloc>().add(
                          FetchSearchEmployeeEvent(searchText),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<SearchEmployeeBloc, SearchEmployeeState>(
                      builder: (context, state) {
                        if (state is SearchEmployeeLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is SearchEmployeeError) {
                          return Text(
                            state.message,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                        if (state is SearchEmployeeSuccess) {
                          final List<SearchEmployeeEntity> employees =
                              state.employees;
                          final String fallbackName =
                              employees.isNotEmpty
                                  ? employees.first.fullName
                                  : 'No Employee Found';
                          _accountHolderController.text = fallbackName;
                          return AppTextInput(
                            controller: _accountHolderController,
                            label: 'Fallback Employee Name',
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            enabled: false,
                            errorText: '',
                          );
                        }
                        return AppTextInput(
                          controller: _accountHolderController,
                          label: 'Fallback Employee Name',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          enabled: false,
                          errorText: '',
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                )
                : const SizedBox.shrink(),
            (selectedLeaveType == '03')
                ? Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppTimePicker(
                            label: "Start Time",
                            selectedTime:
                                _startTimeController, // Replace with a TimeOfDay variable if needed
                            onTimeChanged: (time) {
                              setState(() {
                                _startTimeController = time;
                                final startInMinutes =
                                    time!.hour * 60 + time.minute;
                                final endInMinutes =
                                    startInMinutes +
                                    150; // 2.5 hours = 150 minutes
                                final endHour = (endInMinutes ~/ 60) % 24;
                                final endMinute = endInMinutes % 60;

                                _endTimeController = TimeOfDay(
                                  hour: endHour,
                                  minute: endMinute,
                                );
                              });
                              // Handle start time change
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppTimePicker(
                            label: "End Time",

                            selectedTime:
                                _endTimeController, // Replace with a TimeOfDay variable if needed
                            onTimeChanged: (time) {
                              setState(() {
                                _endTimeController = time;
                              });
                              // Handle end time change
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                )
                : const SizedBox.shrink(),
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    date: startDate,
                    label: "From Date",
                    field: 'from',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDatePicker(
                    date: endDate,
                    label: "To Date",
                    field: 'to',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            (selectedLeaveType! != '03')
                ? Column(
                  children: [
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
                          child: _buildDatePicker(
                            date: rejoinDate,
                            label: "Rejoin Date",
                            field: 'rejoin',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                )
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 2,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Reason for Leave',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit_note),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a reason';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            BlocListener<
              SubmitLeaveApplicationBloc,
              SubmitLeaveApplicationState
            >(
              listener: (context, state) {
                if (state is SubmitLeaveApplicationError) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Oops!',
                      message: state.message!,
                      contentType: ContentType.failure,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }

                if (state is SubmitLeaveApplicationSuccess) {
                  final snackBar = SnackBar(
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Done!',
                      message: state.message!,
                      contentType: ContentType.success,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                }
              },
              child: AppPrimaryButton(
                label: "Apply",
                onPressed: () {
                  context.read<SubmitLeaveApplicationBloc>().add(
                    SubmitLeaveApplicationSubmitted(
                      remarks: _descriptionController.text.trim(),
                      fallbackEmployeeCode:
                          _accountSearchController.text.trim(),
                      rejoiningDate: rejoinDate.toIso8601String(),
                      toDate: endDate.toIso8601String(),
                      fromDate: startDate.toIso8601String(),
                      formTime: _startTimeController?.format(context) ?? '',
                      toTime: _endTimeController?.format(context) ?? '',
                      leaveTypeCode: selectedLeaveType!,
                      leaveStageRemarks: '',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
