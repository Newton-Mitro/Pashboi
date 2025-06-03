import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class SuerityDetails extends StatelessWidget {
  final Map<String, dynamic> surety;
  const SuerityDetails({super.key, required this.surety});

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      return DateTime.parse(
        dateStr,
      ).toLocal().toIso8601String().split('T').first;
    } catch (_) {
      return dateStr; // fallback if parsing fails
    }
  }

  String _boolToYesNo(bool? value) {
    if (value == null) return '';
    return value ? 'Yes' : 'No';
  }

  bool _isNullOrEmpty(dynamic value) {
    if (value == null) return true;
    if (value is String && value.trim().isEmpty) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> items = [];

    void addItem({
      required IconData icon,
      required String label,
      required dynamic value,
      bool isDate = false,
      bool isBool = false,
    }) {
      if (_isNullOrEmpty(value)) return;
      final displayValue =
          isDate
              ? _formatDate(value)
              : isBool
              ? _boolToYesNo(value)
              : value.toString();
      if (displayValue.isEmpty) return;

      items.add(
        _buildItem(context, icon: icon, label: label, value: displayValue),
      );
    }

    addItem(
      icon: Icons.confirmation_num,
      label: 'Loan ID',
      value: surety['LoanId'],
    );
    addItem(
      icon: Icons.date_range,
      label: 'Loan Open Date',
      value: surety['LoanOpenDate'],
      isDate: true,
    );
    addItem(
      icon: Icons.account_circle,
      label: 'Account',
      value: surety['MemberAccount'],
    );
    addItem(icon: Icons.person, label: 'Name', value: surety['MemberName']);
    addItem(
      icon: Icons.phone,
      label: 'Mobile',
      value: surety['MemberMobileNo'],
    );
    addItem(
      icon: Icons.monetization_on,
      label: 'Loan Amount',
      value: surety['LoanAmount'],
    );
    addItem(
      icon: Icons.balance,
      label: 'Loan Balance',
      value: surety['LoanBalance'],
    );
    addItem(
      icon: Icons.lock,
      label: 'Surety Amount',
      value: surety['SuretyAmount'],
    );
    addItem(
      icon: Icons.lock_open,
      label: 'Surety Released',
      value: surety['SuretyReleaseAmount'],
    );
    addItem(
      icon: Icons.date_range,
      label: 'Start Date',
      value: surety['StartDate'],
      isDate: true,
    );
    addItem(
      icon: Icons.calendar_today,
      label: 'End Date',
      value: surety['EndDate'],
      isDate: true,
    );
    addItem(
      icon: Icons.event_available,
      label: 'Last Paid Date',
      value: surety['LastPaidDate'],
      isDate: true,
    );
    addItem(
      icon: Icons.report_problem,
      label: 'Defaulter',
      value: surety['DefaulterStatus'],
      isBool: true,
    );
    addItem(
      icon: Icons.note,
      label: 'Default Details',
      value: surety['DefaultDetails'],
    );
    addItem(icon: Icons.info, label: 'Status', value: surety['SuretyStatus']);
    addItem(icon: Icons.note_alt, label: 'Remarks', value: surety['Remarks']);

    return Column(children: items);
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final color = context.theme.colorScheme.onSurface;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 10),
              Text(label, style: TextStyle(color: color)),
            ],
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(color: color),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
