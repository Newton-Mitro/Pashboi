import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppDropdownSelect<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;

  const AppDropdownSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.errorText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: context.theme.colorScheme.secondary,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: context.theme.colorScheme.onSurface),
            filled: true,
            isDense: true,
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: context.theme.colorScheme.secondary,
                width: 2,
              ),
            ),
            enabledBorder: border,
            errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              items: items,
              onChanged: onChanged,
              isExpanded: true,
              style: TextStyle(
                color: context.theme.colorScheme.onSurface,
                fontSize: 16,
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: context.theme.colorScheme.onSurface,
              ),
              dropdownColor: context.theme.colorScheme.surface,
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 1.0, left: 8),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
