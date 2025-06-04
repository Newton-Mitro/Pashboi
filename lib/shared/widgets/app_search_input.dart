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
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: context.theme.colorScheme.primary,
        width: 1.0,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextField(
            controller: widget.controller,
            obscureText: isObscured,
            keyboardType: widget.keyboardType,
            style: TextStyle(color: context.theme.colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(color: context.theme.colorScheme.onSurface),
              prefixIcon: widget.prefixIcon,
              filled: true,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              focusedBorder: border.copyWith(
                borderSide: BorderSide(
                  color: context.theme.colorScheme.secondary,
                  width: 2.0,
                ),
              ),
              enabledBorder: border,
              errorBorder: border.copyWith(
                borderSide: const BorderSide(color: Colors.red),
              ),
              suffixIcon:
                  widget.obscureText
                      ? _buildIconButton(
                        icon:
                            isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      )
                      : widget.isSearch
                      ? _buildIconButton(
                        icon: Icons.search,
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

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: context.theme.colorScheme.onSurface),
        onPressed: onPressed,
        splashRadius: 20,
      ),
    );
  }
}
