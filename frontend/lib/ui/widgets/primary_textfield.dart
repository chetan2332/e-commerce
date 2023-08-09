import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;

  const PrimaryTextField({
    super.key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: labelText,
      ),
      onChanged: onChanged,
      initialValue: initialValue,
    );
  }
}
