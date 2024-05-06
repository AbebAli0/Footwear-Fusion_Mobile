import 'package:flutter/material.dart';
import 'package:shoes_store/core/theme/theme.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.controller,
      required this.hint,
      this.inputType,
      this.obscureText,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap});
  final TextEditingController controller;
  final String hint;
  final TextInputType? inputType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType ?? TextInputType.text,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(20),
        focusColor: Colors.transparent,
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
