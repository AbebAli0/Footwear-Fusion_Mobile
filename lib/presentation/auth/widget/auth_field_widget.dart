import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({super.key, required this.controller, required this.hint, this.inputType, this.obscureText});
  final TextEditingController controller;
  final String hint;
  final TextInputType? inputType;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        hintText: hint,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint is missing';
        }
        return null;
      },
    );
  }
}
