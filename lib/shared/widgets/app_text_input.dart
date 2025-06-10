import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final void Function(String)? onChanged; // <-- Add this line

  const AppTextInput({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.onChanged, // <-- Add this line
  });

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            controller: widget.controller,
            obscureText: isObscured,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            onChanged: widget.onChanged, // <-- Pass it here
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                color:
                    widget.enabled
                        ? context.theme.colorScheme.onSurface
                        : context.theme.disabledColor,
              ),
              prefixIcon: widget.prefixIcon,
              filled: true,
              hintStyle: TextStyle(color: context.theme.colorScheme.onSurface),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.secondary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.primary,
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.primary.withOpacity(0.3),
                  width: 1.0,
                ),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: context.theme.colorScheme.onSurface,
                        ),
                        onPressed:
                            widget.enabled
                                ? () {
                                  setState(() {
                                    isObscured = !isObscured;
                                  });
                                }
                                : null,
                      )
                      : null,
            ),
            style: TextStyle(
              color:
                  widget.enabled
                      ? context.theme.colorScheme.onSurface
                      : context.theme.disabledColor,
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 1.0, left: 8),
            child: Text(
              widget.errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
