import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppDropdownSelect<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  final String label;
  final String? errorText;
  final IconData? prefixIcon;
  final bool enabled;

  const AppDropdownSelect({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.label,
    this.errorText,
    this.prefixIcon,
    this.enabled = true,
  });

  void _showBottomSheet(BuildContext context) {
    if (!enabled) return;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children:
                items.map((item) {
                  return ListTile(
                    title: item.child,
                    onTap: () {
                      Navigator.of(context).pop();
                      onChanged(item.value);
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: context.theme.colorScheme.primary,
        width: 1.0,
      ),
    );

    final selectedItemText =
        items
            .firstWhere(
              (element) => element.value == value,
              orElse:
                  () => DropdownMenuItem<T>(
                    value: null,
                    child: Text("Select $label"),
                  ),
            )
            .child;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: AbsorbPointer(
            absorbing: !enabled, // ✅ Prevent gestures when disabled
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: value != null ? label : "",
                labelStyle: TextStyle(
                  color:
                      enabled
                          ? context.theme.colorScheme.onSurface
                          : context.theme.disabledColor,
                ),
                filled: true,
                isDense: true,
                prefixIcon:
                    prefixIcon != null
                        ? Icon(
                          prefixIcon,
                          color:
                              enabled
                                  ? context.theme.colorScheme.onSurface
                                  : context.theme.disabledColor,
                        )
                        : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                focusedBorder: border.copyWith(
                  borderSide: BorderSide(
                    color: context.theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
                enabledBorder: border,
                disabledBorder: border.copyWith(
                  borderSide: BorderSide(
                    color: context.theme.colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                errorBorder: border.copyWith(
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      color:
                          enabled
                              ? context.theme.colorScheme.onSurface
                              : context.theme.disabledColor,
                      fontSize: 16,
                    ),
                    child: selectedItemText,
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color:
                        enabled
                            ? context.theme.colorScheme.onSurface
                            : context.theme.disabledColor,
                  ),
                ],
              ),
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
