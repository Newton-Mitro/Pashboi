import 'package:flutter/material.dart';
import 'package:pashboi/core/extensions/app_context.dart';

class AppSearchTextInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final Icon? prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool isSearch;
  final VoidCallback? onSearchPressed;

  const AppSearchTextInput({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.isSearch = false,
    this.onSearchPressed,
  });

  @override
  State<AppSearchTextInput> createState() => _AppSearchTextInputState();
}

class _AppSearchTextInputState extends State<AppSearchTextInput> {
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
              suffixIcon:
                  widget.obscureText
                      ? IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility_off : Icons.visibility,
                          color: context.theme.colorScheme.onSurface,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      )
                      : widget.isSearch
                      ? IconButton(
                        icon: Icon(
                          Icons.search,
                          color: context.theme.colorScheme.onSurface,
                        ),
                        onPressed:
                            widget.onSearchPressed ??
                            () {
                              debugPrint(
                                'Searching: ${widget.controller.text}',
                              );
                            },
                      )
                      : null,
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
