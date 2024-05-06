import 'package:flutter/material.dart';

class PaddingAuth extends StatelessWidget {
  const PaddingAuth({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: child,
    );
  }
}
