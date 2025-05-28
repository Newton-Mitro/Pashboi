import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppSearchInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;

  const AppSearchInput({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<AppSearchInput> createState() => _AppSearchInputState();
}

class _AppSearchInputState extends State<AppSearchInput> {
  late bool isObscured;

  @override
  void initState() {
    super.initState();
    isObscured =
        widget.obscureText; // Initialize with widget's obscureText value
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
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: context.theme.colorScheme.onSurface),
              prefixIcon: widget.prefixIcon,
              filled: true,
              hintStyle: TextStyle(color: context.theme.colorScheme.onSurface),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.secondary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.secondary,
                  width: 1.0,
                ),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        6,
                      ), // Adjust as needed
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {
                        print("Search clicked: ${widget.controller.text}");
                      },
                    ),
                  ),
                  if (widget.obscureText)
                    IconButton(
                      icon: Icon(
                        isObscured ? Icons.visibility_off : Icons.visibility,
                        color: context.theme.colorScheme.onSurface,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscured = !isObscured;
                        });
                      },
                    ),
                ],
              ),
            ),
            style: TextStyle(color: context.theme.colorScheme.onSurface),
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
