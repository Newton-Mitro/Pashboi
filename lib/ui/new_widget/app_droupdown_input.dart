import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppDropdownInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;
  final List<String> items;

  const AppDropdownInput({
    super.key,
    required this.controller,
    required this.label,
    required this.items,
    this.errorText,
    this.prefixIcon,
  });

  @override
  State<AppDropdownInput> createState() => _AppDropdownInputState();
}

class _AppDropdownInputState extends State<AppDropdownInput> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // Set a fixed width for the dropdown
          // Fixed width for the parent widget
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: const TextStyle(color: Colors.white70),
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: const Color(0xFF1A2526), // Dark background
              hintStyle: const TextStyle(color: Colors.white70),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: const BorderSide(
                  color: Colors.blueAccent, // Blue border on focus
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: const BorderSide(
                  color: Colors.white30, // Subtle white border when not focused
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),

            style: const TextStyle(color: Colors.white), // White text
            selectedItemBuilder: (BuildContext context) {
              return widget.items.map((String value) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: const TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList();
            },
            items:
                widget.items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      // color: Colors.transparent,
                      color:
                          selectedValue == value
                              ? Colors
                                  .blueAccent // Blue highlight for selected item
                              : Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                widget.controller.text = value ?? '';
              });
            },
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
