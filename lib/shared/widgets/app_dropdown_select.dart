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
      isScrollControlled: true,
      backgroundColor: context.theme.colorScheme.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (_) {
        final sheetHeight = MediaQuery.of(context).size.height * 0.4;
        return SizedBox(
          height: sheetHeight,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children:
                items.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 5,
                    ),
                    child: ListTile(
                      textColor: context.theme.colorScheme.onPrimary,
                      title: item.child,
                      selected: value == item.value,
                      selectedColor: context.theme.colorScheme.onSecondary,
                      selectedTileColor: context.theme.colorScheme.scrim,
                      hoverColor: context.theme.colorScheme.scrim,
                      focusColor: context.theme.colorScheme.inversePrimary,
                      tileColor: context.theme.colorScheme.secondary,
                      onTap: () {
                        Navigator.of(context).pop();
                        onChanged(item.value);
                      },
                    ),
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

    final selectedItem = items.firstWhere(
      (element) => element.value == value,
      orElse:
          () => DropdownMenuItem<T>(value: null, child: Text("Select $label")),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: AbsorbPointer(
            absorbing: !enabled,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
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
                  Expanded(child: selectedItem.child),
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
        if (errorText != null && errorText!.isNotEmpty)
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
