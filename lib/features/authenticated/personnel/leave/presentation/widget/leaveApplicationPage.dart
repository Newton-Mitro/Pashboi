import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/features/authenticated/personnel/leave/domain/entities/get_leave_type_entity.dart';
import 'package:pashboi/features/authenticated/personnel/leave/presentation/pages/leave_application_page/bloc/leave_type_bloc.dart';
import 'package:pashboi/shared/widgets/app_date_picker.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';
import 'package:pashboi/shared/widgets/app_search_input.dart';
import 'package:pashboi/shared/widgets/app_text_input.dart';
import 'package:pashboi/shared/widgets/buttons/app_primary_button.dart';
import 'package:pashboi/shared/widgets/page_container.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  String? selectedLeaveType;
  final TextEditingController _accountSearchController =
      TextEditingController();
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
    final today = DateTime.now();
    startDate = today;
    endDate = today.add(const Duration(days: 1));
    rejoinDate = endDate.add(const Duration(days: 1));
    _updateTotalDays();
    context.read<LeaveTypeBloc>().add(FetchLeaveTypeEvent());
  }

  void _handleDateChange(DateTime date, {required String field}) {
    setState(() {
      if (field == 'from') {
        startDate = date;
        if (!endDate.isAfter(startDate)) {
          endDate = startDate.add(const Duration(days: 1));
        }
      } else if (field == 'to') {
        endDate = date;
      } else if (field == 'rejoin') {
        rejoinDate = date;
      }

      _errorText =
          endDate.isBefore(startDate)
              ? 'To Date must be after From Date'
              : null;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Leave Application")),
      body: PageContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<LeaveTypeBloc, LeaveTypeState>(
            builder: (context, state) {
              if (state is LeaveTypeLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is LeaveTypeError) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: context.theme.colorScheme.error),
                  ),
                );
              }

              if (state is LeaveTypeSuccess) {
                return _buildForm(state.leaveTypeEntity);
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(List<LeaveTypeEntity> leaveTypes) {
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
              enabled: leaveTypes.isNotEmpty,
              items:
                  leaveTypes
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
              },
            ),
            const SizedBox(height: 16),
            AppTextInput(
              controller: _accountHolderController,
              label: 'Fallback Employee Name',
              prefixIcon: Icon(
                Icons.person_outline,
                color: context.theme.colorScheme.onSurface,
              ),
              enabled: false,
              errorText: '',
            ),
            const SizedBox(height: 16),
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
            TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 4,
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
            AppPrimaryButton(
              label: "Apply",
              onPressed: () {
                // Navigator.pushNamed(context, AuthRoutesName.leaveApplication);
              },
            ),
          ],
        ),
      ),
    );
  }
}
