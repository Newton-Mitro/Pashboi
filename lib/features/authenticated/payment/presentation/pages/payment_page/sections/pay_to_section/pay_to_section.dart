import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pashboi/core/extensions/app_context.dart';
import 'package:pashboi/shared/widgets/app_dropdown_select.dart';

class PayToSection extends StatefulWidget {
  final String? transferToMobile;
  final String? transferToMobileError;
  final void Function(String) onTransferToMobileChanged;

  final String? selectedServiceId;
  final void Function(String?) onServiceChanged;

  final String? notifyPerson;
  final void Function(String?) onNotifyPersonChanged;

  const PayToSection({
    super.key,
    required this.transferToMobile,
    required this.transferToMobileError,
    required this.onTransferToMobileChanged,
    required this.selectedServiceId,
    required this.onServiceChanged,
    required this.notifyPerson,
    required this.onNotifyPersonChanged,
  });

  @override
  State<PayToSection> createState() => _PayToSectionState();
}

class _PayToSectionState extends State<PayToSection> {
  List<Map<String, String>> serviceList = [
    {'id': '1', 'name': 'Electricity'},
    {'id': '2', 'name': 'Gas'},
    {'id': '3', 'name': 'Water'},
    {'id': '4', 'name': 'Internet'},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border.all(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Text(
                "Pay To",
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Form Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 5),

                // ✅ Service Name Dropdown
                AppDropdownSelect(
                  label: 'Service Name',
                  value: widget.selectedServiceId,
                  items:
                      serviceList
                          .map(
                            (service) => DropdownMenuItem<String>(
                              value: service['id'],
                              child: Text(service['name']!),
                            ),
                          )
                          .toList(),
                  onChanged: widget.onServiceChanged,
                  prefixIcon: FontAwesomeIcons.briefcase,
                ),

                const SizedBox(height: 16),

                // ✅ Notify Person Input
                AppDropdownSelect(
                  label: 'Notify Person',
                  value: widget.selectedServiceId,
                  items:
                      serviceList
                          .map(
                            (service) => DropdownMenuItem<String>(
                              value: service['id'],
                              child: Text(service['name']!),
                            ),
                          )
                          .toList(),
                  onChanged: widget.onServiceChanged,
                  prefixIcon: FontAwesomeIcons.userCheck,
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
